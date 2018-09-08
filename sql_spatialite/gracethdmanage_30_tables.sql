/*GraceTHD-Manage v0.01-alpha*/
/*Creation des tables*/
/* gracethdmanage_30_tables.sql */
/*Spatialite*/

/* Owner : GraceTHD-Community - http://gracethd-community.github.io/ */
/* Author : stephane dot byache at aleno dot eu */
/* Rev. date : 04/09/2018 */

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



--SET search_path TO gracethdmanage, gracethd, public;


DROP TABLE IF EXISTS t_mg_filltab;
DROP TABLE IF EXISTS t_mg_fillatt;
DROP TABLE IF EXISTS t_mg_filldoc;
DROP TABLE IF EXISTS t_mg_fillcnt;
DROP TABLE IF EXISTS t_mg_va;
DROP TABLE IF EXISTS t_mg_rx;
DROP TABLE IF EXISTS t_mg_rg;
DROP TABLE IF EXISTS t_mg_db;
DROP TABLE IF EXISTS t_mg_tr;
DROP TABLE IF EXISTS t_mg_xg;
DROP TABLE IF EXISTS t_mg_md;
DROP TABLE IF EXISTS t_mg_ac;
DROP TABLE IF EXISTS t_mg_cn;
DROP TABLE IF EXISTS t_mg_kt;
DROP TABLE IF EXISTS t_mg_pj;
DROP TABLE IF EXISTS t_mg_px;
DROP TABLE IF EXISTS t_mg_ot;
DROP TABLE IF EXISTS t_mg_op;
DROP TABLE IF EXISTS t_mg_ox;
DROP TABLE IF EXISTS t_mg_oo;
DROP TABLE IF EXISTS t_mg_mcdtab;
DROP TABLE IF EXISTS t_mg_mcdatt;
DROP TABLE IF EXISTS t_mg_mcdlist;
DROP TABLE IF EXISTS t_mg_mcdval;
DROP TABLE IF EXISTS t_mg_mcdviews;
DROP TABLE IF EXISTS t_mg_mcdcnt;


CREATE TABLE t_mg_filltab (RESEAU VARCHAR(254) NOT NULL	
	, NOMTABLE VARCHAR(50) NOT NULL    
	, PRE VARCHAR(1)     REFERENCES l_mg_fill(code)
	, DIA VARCHAR(1)     REFERENCES l_mg_fill(code)
	, AVP VARCHAR(1)     REFERENCES l_mg_fill(code)
	, PRO_ou_ACT VARCHAR(1)     REFERENCES l_mg_fill(code)
	, EXE VARCHAR(1)     REFERENCES l_mg_fill(code)
	, TVX_ou_REC VARCHAR(1)     REFERENCES l_mg_fill(code)
	, MCO VARCHAR(1)     REFERENCES l_mg_fill(code)
,CONSTRAINT "t_mg_filltabRESEAU_pk" PRIMARY KEY (RESEAU,NOMTABLE));	
CREATE TABLE t_mg_fillatt (RESEAU VARCHAR(254) NOT NULL	
	, NOMTABLE VARCHAR(40) NOT NULL    
	, ATTRIBUT VARCHAR(50) NOT NULL    
	, ATTUNIQUE VARCHAR(50)  UNIQUE   
	, PRE VARCHAR(1)     REFERENCES l_mg_fill(code)
	, DIA VARCHAR(1)     REFERENCES l_mg_fill(code)
	, AVP VARCHAR(1)     REFERENCES l_mg_fill(code)
	, PRO_ou_ACT VARCHAR(1)     REFERENCES l_mg_fill(code)
	, EXE VARCHAR(1)     REFERENCES l_mg_fill(code)
	, TVX_ou_REC VARCHAR(1)     REFERENCES l_mg_fill(code)
	, MCO VARCHAR(1)     REFERENCES l_mg_fill(code)
,CONSTRAINT "t_mg_fillattRESEAU_pk" PRIMARY KEY (RESEAU,NOMTABLE,ATTRIBUT));	
CREATE TABLE t_mg_filldoc (RESEAU VARCHAR(254) NOT NULL	
	, TYPE VARCHAR(254)     
	, CODETYPE VARCHAR(3) NOT NULL    REFERENCES l_doc_type(code)
	, CONTENU VARCHAR(254)     
	, USAGE VARCHAR(50)     
	, PRE VARCHAR(1)     REFERENCES l_mg_fill(code)
	, DIA VARCHAR(1)     REFERENCES l_mg_fill(code)
	, AVP VARCHAR(1)     REFERENCES l_mg_fill(code)
	, PRO_ou_ACT VARCHAR(1)     REFERENCES l_mg_fill(code)
	, EXE VARCHAR(1)     REFERENCES l_mg_fill(code)
	, TVX_ou_REC VARCHAR(1)     REFERENCES l_mg_fill(code)
	, MCO VARCHAR(1)     REFERENCES l_mg_fill(code)
	, C_INTERNE TEXT     
	, C_EXTERNE TEXT     
	, C_CONTEXT TEXT     
	, C_CONTRAT TEXT     
,CONSTRAINT "t_mg_filldocRESEAU_pk" PRIMARY KEY (RESEAU,CODETYPE));	
CREATE TABLE t_mg_va (va_name VARCHAR(254) NOT NULL	
	, va_def TEXT     
	, va_val TEXT     
,CONSTRAINT "va_name_pk" PRIMARY KEY (va_name));	
CREATE TABLE t_mg_rx (rx_code VARCHAR(254) NOT NULL	
	, rx_r1 VARCHAR(10) NOT NULL    
	, rx_r2 VARCHAR(10)     
	, rx_r3 VARCHAR(10)     
	, rx_r4 VARCHAR(10)     
	, rx_name VARCHAR(254)     
	, rx_or_own VARCHAR(20)     REFERENCES t_organisme(or_code)
	, rx_gc_or_c VARCHAR(20)     REFERENCES t_organisme(or_code)
	, rx_gc_datt DATE     
	, rx_gc_avct INTEGER     REFERENCES l_rx_avct(code)
	, rx_gc_date DATE     
	, rx_gc_statut VARCHAR(3)     
	, rx_cb_or_c VARCHAR(20)     REFERENCES t_organisme(or_code)
	, rx_cb_datt DATE     
	, rx_cb_avct INTEGER     REFERENCES l_rx_avct(code)
	, rx_cb_date DATE     
	, rx_cb_statut VARCHAR(3)     
	, rx_do_or_c VARCHAR(20)     REFERENCES t_organisme(or_code)
	, rx_do_datt DATE     
	, rx_do_avct INTEGER     REFERENCES l_rx_avct(code)
	, rx_do_date DATE     
	, rx_comment VARCHAR(254)     
	, rx_creadat TIMESTAMP     
	, rx_majdate TIMESTAMP     
	, rx_majsrc VARCHAR(254)     
	, rx_abddate DATE     
	, rx_abdsrc VARCHAR(254)     
,CONSTRAINT "rx_code_pk" PRIMARY KEY (rx_code));	
CREATE TABLE t_mg_rg (rg_prefix VARCHAR(2) 	
	, rg_min BIGINT NOT NULL    
	, rg_max BIGINT NOT NULL    
	, rg_step INTEGER     
	, rg_nbcar INTEGER    DEFAULT 12 
	, rg_or_own VARCHAR(20) NOT NULL    REFERENCES t_organisme(or_code)
	, rg_or_usr VARCHAR(20)     
	, rg_datt DATE     
	, rg_dattend DATE     
	, rg_rx_code VARCHAR(254)     REFERENCES t_mg_rx(rx_code)
	, rg_ex VARCHAR(254)     
	, rg_regex VARCHAR(254)     
	, rg_comment VARCHAR(254)     
	, rg_creadat TIMESTAMP     
	, rg_majdate TIMESTAMP     
	, rg_majsrc VARCHAR(254)     
	, rg_abddate DATE     
	, rg_abdsrc VARCHAR(254)     
,CONSTRAINT "rg_prefix_pk" PRIMARY KEY (rg_prefix,rg_min,rg_max));	
CREATE TABLE t_mg_tr (tr_code VARCHAR(254) NOT NULL	
	, tr_type VARCHAR(2) NOT NULL    REFERENCES l_doc_tab(code)
	, tr_typeext VARCHAR(254) NOT NULL    
	, tr_id_ext VARCHAR(254) NOT NULL    
	, tr_etiqext VARCHAR(254)     
	, tr_or_code VARCHAR(20) NOT NULL    REFERENCES t_organisme(or_code)
	, tr_or_role VARCHAR(2)     REFERENCES l_roles(code)
	, tr_dbname VARCHAR(254) NOT NULL    
	, tr_comment VARCHAR(254)     
	, tr_creadat TIMESTAMP     
	, tr_majdate TIMESTAMP     
	, tr_majsrc VARCHAR(254)     
	, tr_abddate DATE     
	, tr_abdsrc VARCHAR(254)     
,CONSTRAINT "tr_code_pk" PRIMARY KEY (tr_code));	
CREATE TABLE t_mg_kt (kt_code VARCHAR(254) NOT NULL	
	, kt_codeext VARCHAR(254)     
	, kt_nom VARCHAR(254)     
	, kt_comment VARCHAR(254)     
	, kt_creadat TIMESTAMP     
	, kt_majdate TIMESTAMP     
	, kt_majsrc VARCHAR(254)     
	, kt_abddate DATE     
	, kt_abdsrc VARCHAR(254)     
,CONSTRAINT "kt_code_pk" PRIMARY KEY (kt_code));	
CREATE TABLE t_mg_pj (pj_code VARCHAR(254) NOT NULL	
	, pj_codeext VARCHAR(254)     
	, pj_pj_code VARCHAR(254)     
	, pj_kt_code VARCHAR(254)     REFERENCES t_mg_kt(kt_code)
	, pj_nom VARCHAR(254)     
	, pj_moa VARCHAR(20)     REFERENCES t_organisme(or_code)
	, pj_moe VARCHAR(20)     REFERENCES t_organisme(or_code)
	, pj_statut VARCHAR(3)     REFERENCES l_statut(code)
	, pj_comment VARCHAR(254)     
	, pj_creadat TIMESTAMP     
	, pj_majdate TIMESTAMP     
	, pj_majsrc VARCHAR(254)     
	, pj_abddate DATE     
	, pj_abdsrc VARCHAR(254)     
,CONSTRAINT "pj_code_pk" PRIMARY KEY (pj_code));	
CREATE TABLE t_mg_px (px_pj_code VARCHAR(254) NOT NULL	
	, px_rx_code VARCHAR(254) NOT NULL    REFERENCES t_mg_rx(rx_code)
	, px_comment VARCHAR(254)     
	, px_creadat TIMESTAMP     
	, px_majdate TIMESTAMP     
	, px_majsrc VARCHAR(254)     
	, px_abddate DATE     
	, px_abdsrc VARCHAR(254)     
,CONSTRAINT "px_pj_code_pk" PRIMARY KEY (px_pj_code,px_rx_code));	
CREATE TABLE t_mg_xg (xg_code VARCHAR(254) NOT NULL	
	, xg_codeext VARCHAR(254)     
	, xg_or_out VARCHAR(20) NOT NULL    REFERENCES t_organisme(or_code)
	, xg_or_in VARCHAR(20) NOT NULL    REFERENCES t_organisme(or_code)
	, xg_rx_code VARCHAR(254)     REFERENCES t_mg_rx(rx_code)
	, xg_pj_code VARCHAR(254)     REFERENCES t_mg_pj(pj_code)
	, xg_ref VARCHAR(254)     
	, xg_track INTEGER     
	, xg_dateout TIMESTAMP     
	, xg_datein TIMESTAMP     
	, xg_comment VARCHAR(254)     
	, xg_creadat TIMESTAMP     
	, xg_majdate TIMESTAMP     
	, xg_majsrc VARCHAR(254)     
	, xg_abddate DATE     
	, xg_abdsrc VARCHAR(254)     
,CONSTRAINT "xg_code_pk" PRIMARY KEY (xg_code));	
CREATE TABLE t_mg_ot (ot_code VARCHAR(254) NOT NULL	
	, ot_codeext VARCHAR(254)     
	, ot_nom VARCHAR(254)     
	, ot_desc VARCHAR(254)     
	, ot_kt_code VARCHAR(254)     REFERENCES t_mg_kt(kt_code)
	, ot_unit VARCHAR(100)     
	, ot_etat VARCHAR(100)     
	, ot_comment VARCHAR(254)     
	, ot_creadat TIMESTAMP     
	, ot_majdate TIMESTAMP     
	, ot_majsrc VARCHAR(254)     
	, ot_abddate DATE     
	, ot_abdsrc VARCHAR(254)     
,CONSTRAINT "ot_code_pk" PRIMARY KEY (ot_code));	
CREATE TABLE t_mg_op (op_code VARCHAR(254) NOT NULL	
	, op_codeext VARCHAR(254)     
	, op_ot_code VARCHAR(254) NOT NULL    REFERENCES t_mg_ot(ot_code)
	, op_pj_code VARCHAR(254)     REFERENCES t_mg_pj(pj_code)
	, op_moa VARCHAR(20)     REFERENCES t_organisme(or_code)
	, op_nbcmd NUMERIC     
	, op_nbrea NUMERIC     
	, op_datrea DATE     
	, op_statut VARCHAR(3)     REFERENCES l_statut(code)
	, op_comment VARCHAR(254)     
	, op_creadat TIMESTAMP     
	, op_majdate TIMESTAMP     
	, op_majsrc VARCHAR(254)     
	, op_abddate DATE     
	, op_abdsrc VARCHAR(254)     
,CONSTRAINT "op_code_pk" PRIMARY KEY (op_code));	
CREATE TABLE t_mg_ox (ox_op_code VARCHAR(254) NOT NULL	
	, ox_rx_code VARCHAR(254) NOT NULL    REFERENCES t_mg_rx(rx_code)
	, ox_comment VARCHAR(254)     
	, ox_creadat TIMESTAMP     
	, ox_majdate TIMESTAMP     
	, ox_majsrc VARCHAR(254)     
	, ox_abddate DATE     
	, ox_abdsrc VARCHAR(254)     
,CONSTRAINT "ox_op_code_pk" PRIMARY KEY (ox_op_code,ox_rx_code));	
CREATE TABLE t_mg_oo (oo_code VARCHAR(254) NOT NULL	
	, oo_type VARCHAR(2) NOT NULL    REFERENCES l_doc_tab(code)
	, oo_codeobj VARCHAR(254) NOT NULL    
	, oo_comment VARCHAR(254)     
	, oo_creadat TIMESTAMP     
	, oo_majdate TIMESTAMP     
	, oo_majsrc VARCHAR(254)     
	, oo_abddate DATE     
	, oo_abdsrc VARCHAR(254)     
,CONSTRAINT "oo_code_pk" PRIMARY KEY (oo_code,oo_codeobj));	
