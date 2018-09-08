/* gracethddata_30_tables.sql */
/* Owner : GraceTHD-Community - http://gracethd-community.github.io/ */
/* Author : stephane dot byache at aleno dot eu */
/* Rev. date : 29/07/2018 */

/* ********************************************************************
    This file is part of GraceTHD.

    GraceTHD is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    GraceTHD is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with GraceTHD.  If not, see <http://www.gnu.org/licenses/>.
*********************************************************************** */


/*TODO: peut-être changer l'archi. Une vue à l'adresse par type d'objet comptabilisé : 
- logements
- pto/lignes
- fibres
Chaque fois avec les codes AD, ZP, ZS, ZN
Ca permet de : 
- n'exécuter que pour ce qu'on veut comptabiliser, donc plus léger. 
- limiter les risques de fonctionnement avec les objets qui ne seraient pas encore dispo. 
Puis une vue globale qui concatène tous les types d'objets. 
Bref, utiliser des vues, plutôt que des WITH. 
*/

/*TODO: à noter qu'on un problème pour comptabiliser à l'adresse si les SUF ne sont pas disponibles (cf. InfraNum)*/

/*TODO: il faut comptabiliser les sf_zp_code qui ne donnent rien. Mais ça ne peut se faire sur cette vue car on synthétise sur les ZP, donc on ne peut avoir les SF orphelins par exemple. */

SET search_path TO gracethdmanage, gracethd, public;

/* ********************************** */
/* Comptage au niveau adresses */
DROP VIEW IF EXISTS v_in_1_nb_ad CASCADE;
CREATE VIEW v_in_1_nb_ad AS
WITH ADSF AS(
SELECT 
	SF.sf_ad_code,
	count(SF.sf_code) AS sfc_nbsf,
	SUM(CASE WHEN SF.sf_racco='AB' THEN 1 ELSE 0 END) AS sfc_nbsfab,
	SUM(CASE WHEN SF.sf_racco='RA' THEN 1 ELSE 0 END) AS sfc_nbsfra,
	SUM(CASE WHEN SF.sf_racco='RB' THEN 1 ELSE 0 END) AS sfc_nbsfrb,
	SUM(CASE WHEN SF.sf_racco='RD' THEN 1 ELSE 0 END) AS sfc_nbsfrd,
	SUM(CASE WHEN SF.sf_racco='EL' THEN 1 ELSE 0 END) AS sfc_nbsfel,
	SUM(CASE WHEN SF.sf_racco='EM' THEN 1 ELSE 0 END) AS sfc_nbsfem,		
	SUM(CASE WHEN SF.sf_racco='PR' THEN 1 ELSE 0 END) AS sfc_nbsfpr--,	
FROM t_suf AS SF
--LEFT JOIN t_suf AS SF ON SF.sf_ad_code = AD.ad_code
GROUP BY SF.sf_ad_code
)

,ADBP AS(
SELECT
	AD.ad_code,
	count(BP.bp_code) AS bpc_nb_pto
FROM 	--vs_elem_bp_sf_nd AS BP 
	t_ebp AS BP
	LEFT JOIN t_suf AS SF ON BP.bp_sf_code = SF.sf_code
	LEFT JOIN t_adresse AS AD ON SF.sf_ad_code = AD.ad_code
WHERE BP.bp_sf_code IS NOT NULL
GROUP BY AD.ad_code --, BP.bp_code
--ORDER BY bpc_nb_pto Desc
)

,ADPS AS( 
--Fibres : Somme des fibres modélisées par dans t_position.ps_1 pour les PTO (t_ebp) associées à cette maille. 
SELECT
	SF.sf_ad_code,
--	ZP.zp_zs_code,
	--ZP.zp_nbpto, --à partir v2.0.2
--	SF.sf_code,
--	SF.sf_ad_code,
--	BP.bp_code, --nb PTO
--	CS.cs_code,
--	PS.ps_1,
	count(PS.ps_1) AS psc_nbps1,
	count(PS.ps_2) AS psc_nbps2
FROM 	t_position AS PS
	LEFT JOIN t_cassette AS CS ON PS.ps_cs_code = CS.cs_code
	LEFT JOIN t_ebp AS BP ON BP.bp_code = CS.cs_bp_code
	LEFT JOIN t_suf AS SF ON SF.sf_code = BP.bp_sf_code
	--LEFT JOIN t_adresse AS ZP ON ZP.zp_code = SF.sf_zp_code
WHERE BP.bp_typelog='PTO' OR BP.bp_typelog='DTI'
GROUP BY SF.sf_ad_code --ps_1 --considérant sens NRO-PTO
)

,ADCBFO1 AS(
--Comptage des fibres déservant des PTO en cb_bp1
SELECT 
	SF.sf_ad_code AS sf_ad_code,
	SUM(CB.cb_capafo) AS cbc_capafo_bp1,
	SUM(CB.cb_fo_util) AS cbc_fo_util_bp1
FROM t_cable AS CB
	LEFT JOIN t_cable_patch201 AS CB201 ON CB201.cb_code = CB.cb_code
	LEFT JOIN t_ebp AS BP
		ON BP.bp_code = CB201.cb_bp1
		AND BP.bp_typelog='PTO' OR BP.bp_typelog='DTI'
	LEFT JOIN t_suf AS SF ON SF.sf_code = BP.bp_sf_code
GROUP BY SF.sf_ad_code
HAVING SF.sf_ad_code IS NOT NULL
)

,ADCBFO2 AS(
--Comptage des fibres déservant des PTO en cb_bp1
SELECT 
	SF.sf_ad_code AS sf_ad_code,
	SUM(CB.cb_capafo) AS cbc_capafo_bp2,
	SUM(CB.cb_fo_util) AS cbc_fo_util_bp2
FROM t_cable AS CB
	LEFT JOIN t_cable_patch201 AS CB201 ON CB201.cb_code = CB.cb_code
	LEFT JOIN t_ebp AS BP
		ON BP.bp_code = CB201.cb_bp2
		AND BP.bp_typelog='PTO' OR BP.bp_typelog='DTI'
	LEFT JOIN t_suf AS SF ON SF.sf_code = BP.bp_sf_code
GROUP BY SF.sf_ad_code
HAVING SF.sf_ad_code IS NOT NULL
)

SELECT
	AD.ad_code,
--	LOGEMENTS
	AD.ad_nblhab + AD.ad_nblpro AS adc_nbl,
	AD.ad_nblhab,
	AD.ad_nblpro,
--	LOGEMENTS ETAT
	AD.ad_ietat,
	--sf_racco
	ADSF.sfc_nbsf,
	ADSF.sfc_nbsfab, --somme des suf abonnes
	ADSF.sfc_nbsfra, --somme des suf raccorde
	ADSF.sfc_nbsfrb, --somme des suf raccordables
	ADSF.sfc_nbsfrd, --somme des suf raccordables sur demande
	ADSF.sfc_nbsfel,
	ADSF.sfc_nbsfem,		
	ADSF.sfc_nbsfpr,		
--	PTO
	AD.ad_nbprhab + AD.ad_nbprpro AS adc_nbpr,
	AD.ad_nbprhab,
	AD.ad_nbprpro,
	ADBP.bpc_nb_pto,
--	Fibres
	ADCBFO1.cbc_capafo_bp1, -- capafo du câble qui arrive en BP1 des EBP de type PBO
	ADCBFO1.cbc_fo_util_bp1,
	ADCBFO2.cbc_capafo_bp2,
	ADCBFO2.cbc_fo_util_bp2,
	ADPS.psc_nbps1,
	ADPS.psc_nbps2	
FROM t_adresse AS AD
LEFT JOIN ADSF ON ADSF.sf_ad_code = AD.ad_code
LEFT JOIN ADBP ON ADBP.ad_code = AD.ad_code
LEFT JOIN ADCBFO1 ON ADCBFO1.sf_ad_code = AD.ad_code
LEFT JOIN ADCBFO2 ON ADCBFO2.sf_ad_code = AD.ad_code
LEFT JOIN ADPS ON ADPS.sf_ad_code = AD.ad_code
;



/* ********************************** */
/* Comptage au niveau PBO */
DROP VIEW IF EXISTS v_in_1_nb_zp CASCADE;
CREATE VIEW v_in_1_nb_zp AS
WITH 
ZPSF AS 
--Nombre de SUF raccordables (sf_racco) par ZP
(SELECT
	SF.sf_zp_code,
	count(SF.sf_zp_code) AS sfc_nbsf,
	SUM(CASE WHEN SF.sf_racco='AB' THEN 1 ELSE 0 END) AS sfc_nbsfab,
	SUM(CASE WHEN SF.sf_racco='RA' THEN 1 ELSE 0 END) AS sfc_nbsfra,
	SUM(CASE WHEN SF.sf_racco='RB' THEN 1 ELSE 0 END) AS sfc_nbsfrb,
	SUM(CASE WHEN SF.sf_racco='RD' THEN 1 ELSE 0 END) AS sfc_nbsfrd,
	SUM(CASE WHEN SF.sf_racco='EL' THEN 1 ELSE 0 END) AS sfc_nbsfel,
	SUM(CASE WHEN SF.sf_racco='EM' THEN 1 ELSE 0 END) AS sfc_nbsfem,		
	SUM(CASE WHEN SF.sf_racco='PR' THEN 1 ELSE 0 END) AS sfc_nbsfpr--,	
	
FROM t_suf AS SF
--LEFT JOIN t_zpbo AS ZP ON ZP.zp_code = SF.sf_zp_code
WHERE SF.sf_zp_code IS NOT NULL
GROUP BY SF.sf_zp_code
)

,ZPBP AS 
--Comptage de PTO par ZP. 
--Nécessaire pour gérer le cas de plusieurs PTO dans un SUF. 
(SELECT
	ZP.zp_code,
	count(BP.bp_code) AS bpc_nb_pto
FROM 	t_ebp AS BP
	LEFT JOIN t_suf AS SF ON BP.bp_sf_code = SF.sf_code
	LEFT JOIN t_zpbo AS ZP ON SF.sf_zp_code = ZP.zp_code
WHERE BP.bp_sf_code IS NOT NULL
GROUP BY ZP.zp_code --, BP.bp_code
--ORDER BY bpc_nb_pto DESC
)

,ZPAD AS( 
--sommes des comptages sur adresse ramenés à la maille ZP
SELECT 
	ZP.zp_code,
--	ZP.zp_zs_code,
	/* compta logements (SUF) */
	--count(ZP.sf_code) AS sfc_nb,
	CASE WHEN count(ZP.zp_code) =0 THEN 0 
		--ELSE sum(AD.ad_nblhab)/count(ZP.zp_code) + sum(AD.ad_nblpro)/count(ZP.zp_code) 
		ELSE sum(AD.ad_nblhab) + sum(AD.ad_nblpro) 
	END AS adc_nbl, --total des locaux
	CASE WHEN count(ZP.zp_code) =0 THEN 0 ELSE sum(AD.ad_nblhab) END AS ad_nblhab,
	CASE WHEN count(ZP.zp_code) =0 THEN 0 ELSE sum(AD.ad_nblpro) END AS ad_nblpro,
	/* compta logements raccordables */
	--TODO
	/* compta PTO (lignes) */
	CASE WHEN count(ZP.zp_code) =0 THEN 0 
		ELSE sum(AD.ad_nbprhab)/count(ZP.zp_code) + sum(AD.ad_nbprpro)/count(ZP.zp_code) 
	END AS adc_nbpr, --total des fibres
	CASE WHEN count(ZP.zp_code) =0 THEN 0 ELSE sum(AD.ad_nbprhab) END AS ad_nbprhab,
	CASE WHEN count(ZP.zp_code) =0 THEN 0 ELSE sum(AD.ad_nbprpro) END AS ad_nbprpro
	--TODO : zpc_nbpto 
	--count(ZP.bp_code) AS bpc_nb
	/* compta fibres */
	--TODO
FROM 	t_suf AS SF
	LEFT JOIN t_zpbo AS ZP ON SF.sf_zp_code=ZP.zp_code --ZPSF AS ZP
	LEFT JOIN t_adresse AS AD ON SF.sf_ad_code=AD.ad_code
WHERE SF.sf_zp_code IS NOT NULL
GROUP BY 
ZP.zp_code--,
--ZP.zp_zs_code
)

,ZPCBFOPTO AS(
--Comptage des fibres comptées sur le câble qui dessert la PTO
--TODO: NOK, besoin de données t_cable_patch201 pour développer et tester. 
SELECT 
	ZP201_1.zp_code AS zp_code,
	COUNT(BP1.bp_code) AS bp_code	
FROM t_cable AS CB
	LEFT JOIN t_cable_patch201 AS CB201 ON CB201.cb_code = CB.cb_code
	LEFT JOIN t_ebp AS BP1 ON BP1.bp_code = CB201.cb_bp1
	LEFT JOIN t_zpbo_patch201 AS ZP201_1 ON ZP201_1.zp_bp_code = BP1.bp_code
WHERE 	BP1.bp_typelog='PTO' 
	OR BP1.bp_typelog='DTI'
GROUP BY ZP201_1.zp_code
UNION
SELECT 
	ZP201_2.zp_code AS zp_code,
	COUNT(BP2.bp_code) AS bp_code
FROM t_cable AS CB
	LEFT JOIN t_cable_patch201 AS CB201 ON CB201.cb_code = CB.cb_code
	LEFT JOIN t_ebp AS BP2 ON BP2.bp_code = CB201.cb_bp2
	LEFT JOIN t_zpbo_patch201 AS ZP201_2 ON ZP201_2.zp_bp_code = BP2.bp_code
WHERE 
	BP2.bp_typelog='PTO'
	OR BP2.bp_typelog='DTI'
GROUP BY ZP201_2.zp_code
)

,ZPCBFO1 AS(
--Comptage des fibres comptées sur le câble qui dessert le PBO en cb_bp1
SELECT 
	ZP201.zp_code AS zp_code,
	SUM(CB.cb_capafo) AS cbc_capafo_bp1,
	SUM(CB.cb_fo_util) AS cbc_fo_util_bp1
FROM t_cable AS CB
	LEFT JOIN t_cable_patch201 AS CB201 ON CB201.cb_code = CB.cb_code
	LEFT JOIN t_ebp AS BP
		ON BP.bp_code = CB201.cb_bp1
		AND BP.bp_typelog='PBO'
	LEFT JOIN t_zpbo_patch201 AS ZP201 ON ZP201.zp_bp_code = BP.bp_code
GROUP BY ZP201.zp_code
HAVING ZP201.zp_code IS NOT NULL
)

,ZPCBFO2 AS(
--Comptage des fibres comptées sur le câble qui dessert le PBO en cb_bp2
SELECT 
	ZP201.zp_code AS zp_code,
	SUM(CB.cb_capafo) AS cbc_capafo_bp2,
	SUM(CB.cb_fo_util) AS cbc_fo_util_bp2
FROM t_cable AS CB
	LEFT JOIN t_cable_patch201 AS CB201 ON CB201.cb_code = CB.cb_code
	LEFT JOIN t_ebp AS BP
		ON BP.bp_code = CB201.cb_bp2
		AND BP.bp_typelog='PBO'
	LEFT JOIN t_zpbo_patch201 AS ZP201 ON ZP201.zp_bp_code = BP.bp_code
GROUP BY ZP201.zp_code
HAVING ZP201.zp_code IS NOT NULL

)

,ZPPS AS( 
--Fibres : Somme des fibres modélisées par dans t_position.ps_1 pour les PTO (t_ebp) associées à cette maille. 
--A priori jouable dans ZPSF ?
SELECT
	ZP.zp_code,
--	ZP.zp_zs_code,
	--ZP.zp_nbpto, --à partir v2.0.2
--	SF.sf_code,
--	SF.sf_ad_code,
--	BP.bp_code, --nb PTO
--	CS.cs_code,
--	PS.ps_1,
	count(PS.ps_1) AS psc_nbps1,
	count(PS.ps_2) AS psc_nbps2
FROM 	t_position AS PS
	LEFT JOIN t_cassette AS CS ON PS.ps_cs_code = CS.cs_code
	LEFT JOIN t_ebp AS BP ON BP.bp_code = CS.cs_bp_code
	LEFT JOIN t_suf AS SF ON SF.sf_code = BP.bp_sf_code
	LEFT JOIN t_zpbo AS ZP ON ZP.zp_code = SF.sf_zp_code
WHERE BP.bp_typelog='PTO' OR BP.bp_typelog='DTI'
GROUP BY ZP.zp_code --ps_1 --considérant sens NRO-PTO
)


SELECT 
	ZP.zp_code,
	ZP.zp_zs_code,
--	LOGEMENTS
	--ZPAD.sfc_nb, --Somme des SUF du ZP --zpc_nbsf ?
	ZPAD.adc_nbl, --Somme des logements comptabilisés dans t_adresse (ad_nblhab + ad_nblpro du ZP) --zpc_ad_nbl ?
	ZPAD.ad_nblhab, --zpc_ad_nblhab ?
	ZPAD.ad_nblpro, --zpc_ad_nblpro ?
	ZPSF.sfc_nbsf, --
--	LOGEMENTS RACCORDABLES
	--TODO: --ad_ietat

	--sf_racco
	ZPSF.sfc_nbsfab, --somme des suf abonnes
	ZPSF.sfc_nbsfra, --somme des suf raccorde
	ZPSF.sfc_nbsfrb, --somme des suf raccordables
	ZPSF.sfc_nbsfrd, --somme des suf raccordables sur demande
	ZPSF.sfc_nbsfel,
	ZPSF.sfc_nbsfem,		
	ZPSF.sfc_nbsfpr,	
--	PTO(LIGNES)
	ZPAD.adc_nbpr, --Somme des prises (PTO) des attributs ad_nbpr* --zpc_ad_nbpr
	ZPAD.ad_nbprhab, --zpc_ad_nbprhab
	ZPAD.ad_nbprpro, --zpc_ad_nbprpro
	ZP.zp_capamax,
	ZPBP.bpc_nb_pto, --zpc_nbbp_pto
--	FIBRES
	ZPCBFO1.cbc_capafo_bp1, -- capafo du câble qui arrive en BP1 des EBP de type PBO
	ZPCBFO1.cbc_fo_util_bp1,
	ZPCBFO2.cbc_capafo_bp2,
	ZPCBFO2.cbc_fo_util_bp2,
	--foc_nb : voir si on peut comptabiliser les fibres modélisées sans passer par les positions, juste avec t_cable_patch201
	ZPPS.psc_nbps1,
	ZPPS.psc_nbps2
FROM t_zpbo AS ZP
LEFT JOIN ZPAD ON ZP.zp_code=ZPAD.zp_code
LEFT JOIN ZPBP ON ZPBP.zp_code=ZP.zp_code
LEFT JOIN ZPSF ON ZPSF.sf_zp_code=ZP.zp_code
LEFT JOIN ZPCBFO1 ON ZPCBFO1.zp_code = ZP.zp_code
LEFT JOIN ZPCBFO2 ON ZPCBFO2.zp_code = ZP.zp_code
LEFT JOIN ZPPS ON ZPPS.zp_code=ZP.zp_code
;


/* ******************************* */ 
/* Comptage au niveau SRO */
DROP VIEW IF EXISTS v_in_1_nb_zs CASCADE;
CREATE VIEW v_in_1_nb_zs AS
/*
WITH ZSCBFO1 AS(
--Comptage des fibres des câbles à la baie
)

,ZSCBFO2 AS(
--Comptage des fibres des câbles à la baie
)

,ZSPS AS(
)
*/

SELECT 
	ZS.zs_code, 
	ZS.zs_zn_code,
--	LOGEMENTS
	SUM(ZP.adc_nbl) AS adc_nbl, --Somme des logements comptabilisés dans t_adresse (ad_nblhab + ad_nblpro du ZP) --zpc_ad_nbl ?
	SUM(ZP.ad_nblhab) AS ad_nblhab, --zpc_ad_nblhab ?
	SUM(ZP.ad_nblpro) AS ad_nblpro, --zpc_ad_nblpro ?
	SUM(ZP.sfc_nbsf) AS sfc_nbsf, --
--	LOGEMENTS RACCORDABLES
	--TODO: --ad_ietat
	--sf_racco
	SUM(ZP.sfc_nbsfab) AS sfc_nbsfab, --somme des suf abonnes
	SUM(ZP.sfc_nbsfra) AS sfc_nbsfra, --somme des suf raccorde
	SUM(ZP.sfc_nbsfrb) AS sfc_nbsfrb, --somme des suf raccordables
	SUM(ZP.sfc_nbsfrd) AS sfc_nbsfrd, --somme des suf raccordables sur demande
	SUM(ZP.sfc_nbsfel) AS sfc_nbsfel,
	SUM(ZP.sfc_nbsfem) AS sfc_nbsfem,		
	SUM(ZP.sfc_nbsfpr)AS sfc_nbsfpr,	
--	PTO(LIGNES)
	SUM(ZP.adc_nbpr) AS adc_nbpr, --Somme des prises (PTO) des attributs ad_nbpr* --zpc_ad_nbpr
	SUM(ZP.ad_nbprhab) AS ad_nbprhab, --zpc_ad_nbprhab
	SUM(ZP.ad_nbprpro) AS ad_nbprpro, --zpc_ad_nbprpro
	--ZP.zp_capamax, --INUTILISABLE AU NIVEAU SRO
	SUM(ZP.bpc_nb_pto) AS bpc_nb_pto --, --zpc_nbbp_pto
--	FIBRES
/* --TODO: FAUX, il faut recalculer au SRO, pas la somme des fo au PBO !
	SUM(ZP.cbc_capafo_bp1) AS cbc_capafo_bp1,
	SUM(ZP.cbc_fo_util_bp1) AS cbc_fo_util_bp1,
	SUM(ZP.cbc_capafo_bp2) AS cbc_capafo_bp2,
	SUM(ZP.cbc_fo_util_bp2) AS cbc_fo_util_bp2,
	SUM(ZP.psc_nbps1) AS psc_nbps1,
	SUM(ZP.psc_nbps2) AS psc_nbps2
*/

FROM v_in_1_nb_zp AS ZP
LEFT JOIN t_zsro AS ZS ON ZS.zs_code = ZP.zp_zs_code
--TODO: st_nblignes
GROUP BY ZS.zs_code
;


/* ******************************* */ 
/* Comptage au niveau NRO */
DROP VIEW IF EXISTS v_in_1_nb_zn CASCADE;
CREATE VIEW v_in_1_nb_zn AS

/*
WITH 
ZNCBFO1 AS(
--Comptage des fibres des câbles à la baie
)

,ZNCBFO2 AS(
--Comptage des fibres des câbles à la baie
)

,ZNPS AS(
)
*/

SELECT 
	ZN.zn_code, 
--	LOGEMENTS
	--ZPAD.sfc_nb, --Somme des SUF du ZP --zpc_nbsf ?
	SUM(ZS.adc_nbl) AS adc_nbl, --Somme des logements comptabilisés dans t_adresse (ad_nblhab + ad_nblpro du ZP) --zpc_ad_nbl ?
	SUM(ZS.ad_nblhab) AS ad_nblhab, --zpc_ad_nblhab ?
	SUM(ZS.ad_nblpro) AS ad_nblpro, --zpc_ad_nblpro ?
	SUM(ZS.sfc_nbsf) AS sfc_nbsf, --
--	LOGEMENTS RACCORDABLES
	--TODO: --ad_ietat

	--sf_racco
	SUM(ZS.sfc_nbsfab) AS sfc_nbsfab, --somme des suf abonnes
	SUM(ZS.sfc_nbsfra) AS sfc_nbsfra, --somme des suf raccorde
	SUM(ZS.sfc_nbsfrb) AS sfc_nbsfrb, --somme des suf raccordables
	SUM(ZS.sfc_nbsfrd) AS sfc_nbsfrd, --somme des suf raccordables sur demande
	SUM(ZS.sfc_nbsfel) AS sfc_nbsfel,
	SUM(ZS.sfc_nbsfem) AS sfc_nbsfem,		
	SUM(ZS.sfc_nbsfpr)AS sfc_nbsfpr,	
--	PTO(LIGNES)
	SUM(ZS.adc_nbpr) AS adc_nbpr, --Somme des prises (PTO) des attributs ad_nbpr* --zpc_ad_nbpr
	SUM(ZS.ad_nbprhab) AS ad_nbprhab, --zpc_ad_nbprhab
	SUM(ZS.ad_nbprpro) AS ad_nbprpro, --zpc_ad_nbprpro
	--ZP.zp_capamax, --INUTILISABLE AU NIVEAU SRO
	SUM(ZS.bpc_nb_pto) AS bpc_nb_pto --, --zpc_nbbp_pto
--	FIBRES
	--TODO:
/* --TODO: FAUX, il faut recalculer au SRO, pas la somme des fo au PBO !
	SUM(ZP.cbc_capafo_bp1) AS cbc_capafo_bp1,
	SUM(ZP.cbc_fo_util_bp1) AS cbc_fo_util_bp1,
	SUM(ZP.cbc_capafo_bp2) AS cbc_capafo_bp2,
	SUM(ZP.cbc_fo_util_bp2) AS cbc_fo_util_bp2,
	SUM(ZP.psc_nbps1) AS psc_nbps1,
	SUM(ZP.psc_nbps2) AS psc_nbps2
*/
FROM v_in_1_nb_zs AS ZS
LEFT JOIN t_znro AS ZN ON ZN.zn_code = ZS.zs_zn_code
--TODO: st_nblignes
GROUP BY ZN.zn_code
;
