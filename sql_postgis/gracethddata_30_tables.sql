/* gracethddata_30_tables.sql */
/* Owner : GraceTHD-Community - http://gracethd-community.github.io/ */
/* Author : stephane dot byache at aleno dot eu */
/* Rev. date : 25/06/2018 */

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

DROP TABLE IF EXISTS t_dt_reference_rel CASCADE;
DROP TABLE IF EXISTS t_dt_organisme_rel CASCADE;
DROP TABLE IF EXISTS t_dt_organisme CASCADE;
DROP TABLE IF EXISTS t_dt_reference CASCADE;
DROP TABLE IF EXISTS t_dt_tgkey CASCADE;
DROP TABLE IF EXISTS t_dt_tgkey_user CASCADE;
DROP TABLE IF EXISTS t_dt_tag CASCADE;
DROP TABLE IF EXISTS t_dt_tag_user CASCADE;


CREATE TABLE t_dt_organisme(	or_code VARCHAR (20) NOT NULL  ,
	or_siren VARCHAR(9)   ,
	or_nom VARCHAR(254) NOT NULL  ,
	or_type VARCHAR(254)   ,
	or_activ VARCHAR(254)   ,
	or_l331 VARCHAR(254)   ,
	or_siret VARCHAR(14)   ,
	or_nometab VARCHAR(254)   ,
	or_ad_code VARCHAR(254), --   REFERENCES t_adresse(ad_code),
	or_nomvoie VARCHAR (254)   ,
	or_numero INTEGER   ,
	or_rep VARCHAR (20)   ,
	or_local VARCHAR(254)   ,
	or_postal VARCHAR(20)   ,
	or_commune VARCHAR (254)   ,
	or_telfixe VARCHAR(20)   ,
	or_mail VARCHAR(254)   ,
	or_comment VARCHAR(254)   ,
	or_creadat TIMESTAMP   ,
	or_majdate TIMESTAMP   ,
	or_majsrc VARCHAR(254)   ,
	or_abddate DATE   ,
	or_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_dt_organisme_pk" PRIMARY KEY (or_code));	

CREATE TABLE t_dt_reference(	rf_code VARCHAR(254) NOT NULL  ,
	rf_type VARCHAR(2)   REFERENCES l_reference_type (code),
	rf_fabric VARCHAR(20)  REFERENCES t_dt_organisme (or_code),
	rf_design VARCHAR(254)   ,
	rf_etat VARCHAR(1)   REFERENCES l_reference_etat (code),
	rf_comment VARCHAR(254)   ,
	rf_creadat TIMESTAMP   ,
	rf_majdate TIMESTAMP   ,
	rf_majsrc VARCHAR(254)   ,
	rf_abddate DATE   ,
	rf_abdsrc VARCHAR(254)   ,
CONSTRAINT "t_dt_reference_pk" PRIMARY KEY (rf_code));	

CREATE TABLE t_dt_organisme_rel(
	oo_codedat VARCHAR(254) REFERENCES t_dt_organisme(or_code),
	oo_or_code VARCHAR(254) REFERENCES t_organisme(or_code),
CONSTRAINT "t_dt_organisme_rel_pk" PRIMARY KEY (oo_codedat, oo_or_code)
);

CREATE TABLE t_dt_reference_rel(
	rr_codedat VARCHAR(254) REFERENCES t_dt_reference(rf_code),
	rr_rf_code VARCHAR(254) REFERENCES t_reference(rf_code),
CONSTRAINT "t_dt_reference_rel_pk" PRIMARY KEY (rr_codedat, rr_rf_code)
);

CREATE TABLE t_dt_tgkey (
	tk_key VARCHAR(20) NOT NULL, --(clé)
	tk_def VARCHAR(254), --définition de clé de tag. 
	tk_comment VARCHAR(254),
	tk_creadat TIMESTAMP, 
	tk_majdate TIMESTAMP,
	tk_majsrc VARCHAR(254),
	tk_abddate DATE,
	tk_abdsrc VARCHAR(254),
	CONSTRAINT "t_dt_tgkey_pk" PRIMARY KEY (tk_key)
);

CREATE TABLE t_dt_tag (
	tg_key VARCHAR(20) NOT NULL REFERENCES t_dt_key(tk_tgkey), --(clé)
	tg_val VARCHAR(20) NOT NULL, -- valeur possible pour une clé. 
	tg_def VARCHAR(254), --définition du tag, c'est à dire du couple clé/valeur. 
	tg_comment VARCHAR(254),
	tg_creadat TIMESTAMP, 
	tg_majdate TIMESTAMP,
	tg_majsrc VARCHAR(254),
	tg_abddate DATE,
	tg_abdsrc VARCHAR(254),
	CONSTRAINT "t_dt_tag_pk" PRIMARY KEY (tg_key, tg_val)
);

CREATE TABLE t_dt_tgkey_user (
	tk_key VARCHAR(20) NOT NULL CHECK(tk_key LIKE 'usr%'), --(clé)
	tk_def VARCHAR(254), --définition de clé de tag. 
	tk_comment VARCHAR(254),
	tk_creadat TIMESTAMP, 
	tk_majdate TIMESTAMP,
	tk_majsrc VARCHAR(254),
	tk_abddate DATE,
	tk_abdsrc VARCHAR(254),
	CONSTRAINT "t_dt_tgkey_user_pk" PRIMARY KEY (tk_key)
);

CREATE TABLE t_dt_tag_user (
	tg_key VARCHAR(20) NOT NULL REFERENCES t_dt_key_user(tk_tgkey), --(clé)
	tg_val VARCHAR(20) NOT NULL, -- valeur possible pour une clé. 
	tg_def VARCHAR(254), --définition du tag, c'est à dire du couple clé/valeur. 
	tg_comment VARCHAR(254),
	tg_creadat TIMESTAMP, 
	tg_majdate TIMESTAMP,
	tg_majsrc VARCHAR(254),
	tg_abddate DATE,
	tg_abdsrc VARCHAR(254),
	CONSTRAINT "t_dt_tag_user_pk" PRIMARY KEY (tg_key, tg_val)
);
