/* gracethddata_60_views.sql */
/* Owner : GraceTHD-Community - http://gracethd-community.github.io/ */
/* Author : stephane dot byache at aleno dot eu */
/* Rev. date : 23/05/2018 */

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

/*PostGIS*/

SET search_path TO gracethddata, gracethd, public;

DROP VIEW IF EXISTS v_dt_organisme_int CASCADE;
DROP VIEW IF EXISTS v_dt_organisme CASCADE;
DROP VIEW IF EXISTS v_dt_organisme_ok CASCADE;
DROP VIEW IF EXISTS v_dt_reference_int CASCADE;
DROP VIEW IF EXISTS v_dt_reference CASCADE;
DROP VIEW IF EXISTS v_dt_reference_ok CASCADE;

/* Les organismes internes, donc sans mise en correspondance avec t_dt_organisme via t_dt_organisme_rel*/
CREATE VIEW v_dt_organisme_int AS
SELECT 
	O.or_code,
	O.or_siren,
	O.or_nom,
	O.or_type,
	O.or_activ,
	O.or_l331,
	O.or_siret,
	O.or_nometab,
	O.or_ad_code,
	O.or_nomvoie,
	O.or_numero,
	O.or_rep,
	O.or_local,
	O.or_postal,
	O.or_commune,
	O.or_telfixe,
	O.or_mail,
	O.or_comment,
	O.or_creadat,
	O.or_majdate,
	O.or_majsrc,
	O.or_abddate,
	O.or_abdsrc	
FROM t_organisme AS O
LEFT JOIN t_dt_organisme_rel AS R ON O.or_code = R.oo_or_code 
WHERE R.oo_or_code IS NULL
ORDER BY O.or_code
;


/*Les organismes_data sélectionnés via la table de relation*/
CREATE VIEW v_dt_organisme AS
SELECT
	D.or_code,
	D.or_siren,
	D.or_nom,
	D.or_type,
	D.or_activ,
	D.or_l331,
	D.or_siret,
	D.or_nometab,
	D.or_ad_code,
	D.or_nomvoie,
	D.or_numero,
	D.or_rep,
	D.or_local,
	D.or_postal,
	D.or_commune,
	D.or_telfixe,
	D.or_mail,
	D.or_comment,
	D.or_creadat,
	D.or_majdate,
	D.or_majsrc,
	D.or_abddate,
	D.or_abdsrc	
FROM t_dt_organisme AS D, t_dt_organisme_rel AS R
WHERE 
D.or_code = R.oo_codedat
;

/* Les organismes valables en interne (int + data) */
CREATE VIEW v_dt_organisme_ok AS
SELECT * FROM v_dt_organisme_int
UNION
SELECT * FROM v_dt_organisme
ORDER BY or_code
;


/* ************************************* */

/* Les references internes, donc sans mise en correspondance avec t_dt_reference via t_dt_reference_rel*/
CREATE VIEW v_dt_reference_int AS
SELECT 
	T.rf_code,
  T.rf_type,
  T.rf_fabric,
  T.rf_design,
  T.rf_etat,
  T.rf_comment,
  T.rf_creadat,
  T.rf_majdate,
  T.rf_majsrc,
  T.rf_abddate,
  T.rf_abdsrc
FROM t_reference AS T
LEFT JOIN t_dt_reference_rel AS R ON T.rf_code = R.rr_rf_code 
WHERE R.rr_rf_code IS NULL
ORDER BY T.rf_code
;


/*Les références GraceTHD-Data sélectionnés via la table de relation*/
CREATE VIEW v_dt_reference AS
SELECT
	T.rf_code,
  T.rf_type,
  T.rf_fabric,
  T.rf_design,
  T.rf_etat,
  T.rf_comment,
  T.rf_creadat,
  T.rf_majdate,
  T.rf_majsrc,
  T.rf_abddate,
  T.rf_abdsrc
FROM t_dt_reference AS T, t_dt_reference_rel AS R
WHERE 
T.rf_code = R.rr_codedat
;


/* Les références valables en interne (int + data) */
CREATE VIEW v_dt_reference_ok AS
SELECT * FROM v_dt_reference_int
UNION
SELECT * FROM v_dt_reference
ORDER BY rf_code
;


