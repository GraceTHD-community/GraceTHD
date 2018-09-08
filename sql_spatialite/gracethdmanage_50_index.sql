/*GraceTHD-Manage v0.01-alpha*/
/*Creation des indexes*/
/* gracethdmanage_50_index.sql */
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

DROP INDEX IF EXISTS ATTRIBUT_idx; CREATE INDEX  ATTRIBUT_idx ON t_mg_fillatt(ATTRIBUT);
DROP INDEX IF EXISTS ATTUNIQUE_idx; CREATE INDEX  ATTUNIQUE_idx ON t_mg_fillatt(ATTUNIQUE);











DROP INDEX IF EXISTS CONTENU_idx; CREATE INDEX  CONTENU_idx ON t_mg_filldoc(CONTENU);
DROP INDEX IF EXISTS USAGE_idx; CREATE INDEX  USAGE_idx ON t_mg_filldoc(USAGE);














DROP INDEX IF EXISTS va_val_idx; CREATE INDEX  va_val_idx ON t_mg_va(va_val);


DROP INDEX IF EXISTS rx_idx; CREATE UNIQUE INDEX  rx_idx ON t_mg_rx(rx_r1,rx_r2,rx_r3,rx_r4);



DROP INDEX IF EXISTS rx_name_idx; CREATE INDEX  rx_name_idx ON t_mg_rx(rx_name);



























































DROP INDEX IF EXISTS xg_code_idx; CREATE INDEX  xg_code_idx ON t_mg_xg(xg_code);
DROP INDEX IF EXISTS xg_codeext_idx; CREATE INDEX  xg_codeext_idx ON t_mg_xg(xg_codeext);
DROP INDEX IF EXISTS xg_or_out_idx; CREATE INDEX  xg_or_out_idx ON t_mg_xg(xg_or_out);
DROP INDEX IF EXISTS xg_or_in_idx; CREATE INDEX  xg_or_in_idx ON t_mg_xg(xg_or_in);
DROP INDEX IF EXISTS xg_rx_code_idx; CREATE INDEX  xg_rx_code_idx ON t_mg_xg(xg_rx_code);
DROP INDEX IF EXISTS xg_pj_code_idx; CREATE INDEX  xg_pj_code_idx ON t_mg_xg(xg_pj_code);
DROP INDEX IF EXISTS xg_ref_idx; CREATE INDEX  xg_ref_idx ON t_mg_xg(xg_ref);
DROP INDEX IF EXISTS xg_track_idx; CREATE INDEX  xg_track_idx ON t_mg_xg(xg_track);
DROP INDEX IF EXISTS xg_dateout_idx; CREATE INDEX  xg_dateout_idx ON t_mg_xg(xg_dateout);
DROP INDEX IF EXISTS xg_datein_idx; CREATE INDEX  xg_datein_idx ON t_mg_xg(xg_datein);







DROP INDEX IF EXISTS kt_code_idx; CREATE INDEX  kt_code_idx ON t_mg_kt(kt_code);
DROP INDEX IF EXISTS kt_codeext_idx; CREATE INDEX  kt_codeext_idx ON t_mg_kt(kt_codeext);
DROP INDEX IF EXISTS kt_nom_idx; CREATE INDEX  kt_nom_idx ON t_mg_kt(kt_nom);







DROP INDEX IF EXISTS pj_code_idx; CREATE INDEX  pj_code_idx ON t_mg_pj(pj_code);
DROP INDEX IF EXISTS pj_codeext_idx; CREATE INDEX  pj_codeext_idx ON t_mg_pj(pj_codeext);
DROP INDEX IF EXISTS pj_pj_code_idx; CREATE INDEX  pj_pj_code_idx ON t_mg_pj(pj_pj_code);

DROP INDEX IF EXISTS pj_nom_idx; CREATE INDEX  pj_nom_idx ON t_mg_pj(pj_nom);
DROP INDEX IF EXISTS pj_moa_idx; CREATE INDEX  pj_moa_idx ON t_mg_pj(pj_moa);
DROP INDEX IF EXISTS pj_moe_idx; CREATE INDEX  pj_moe_idx ON t_mg_pj(pj_moe);
DROP INDEX IF EXISTS pj_statut_idx; CREATE INDEX  pj_statut_idx ON t_mg_pj(pj_statut);







DROP INDEX IF EXISTS px_pj_code_idx; CREATE INDEX  px_pj_code_idx ON t_mg_px(px_pj_code);
DROP INDEX IF EXISTS px_rx_code_idx; CREATE INDEX  px_rx_code_idx ON t_mg_px(px_rx_code);







DROP INDEX IF EXISTS ot_code_idx; CREATE INDEX  ot_code_idx ON t_mg_ot(ot_code);
DROP INDEX IF EXISTS ot_codeext_idx; CREATE INDEX  ot_codeext_idx ON t_mg_ot(ot_codeext);












DROP INDEX IF EXISTS op_code_idx; CREATE INDEX  op_code_idx ON t_mg_op(op_code);
DROP INDEX IF EXISTS op_codeext_idx; CREATE INDEX  op_codeext_idx ON t_mg_op(op_codeext);


DROP INDEX IF EXISTS op_moa_idx; CREATE INDEX  op_moa_idx ON t_mg_op(op_moa);



DROP INDEX IF EXISTS op_statut_idx; CREATE INDEX  op_statut_idx ON t_mg_op(op_statut);







DROP INDEX IF EXISTS ox_op_code_idx; CREATE INDEX  ox_op_code_idx ON t_mg_ox(ox_op_code);
DROP INDEX IF EXISTS ox_rx_code_idx; CREATE INDEX  ox_rx_code_idx ON t_mg_ox(ox_rx_code);







DROP INDEX IF EXISTS oo_code_idx; CREATE INDEX  oo_code_idx ON t_mg_oo(oo_code);

DROP INDEX IF EXISTS oo_codeobj_idx; CREATE INDEX  oo_codeobj_idx ON t_mg_oo(oo_codeobj);
