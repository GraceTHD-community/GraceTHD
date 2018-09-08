/* gracethdmanage_33_va_insert.sql */
/* Owner : GraceTHD-Community - http://gracethd-community.github.io/ */
/* Author : stephane dot byache at aleno dot eu */
/* Rev. date : 26/08/2018 */

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

/*Vider t_ct_conf*/
DELETE FROM t_mg_va; --Spatialite
--TRUNCATE t_mg_va; --postgis

/*Renseigner t_mg_va avec les valeurs par défaut*/
BEGIN;
INSERT INTO t_mg_va VALUES ('va_1_cbcapamax','Capacite maximale des cables','780');
INSERT INTO t_mg_va VALUES ('va_1_cbcapamin','Capacite minimale des cables','2');
INSERT INTO t_mg_va VALUES ('va_1_cldistmaxnd','Distance maximale entre les extremites d un cable et une bp ou lt','0.1');
INSERT INTO t_mg_va VALUES ('va_1_distnrozanro','Distance maximale entre le NRO et sa zone arriere (0 si le NRO doit etre a l interieur)','0');
INSERT INTO t_mg_va VALUES ('va_1_distpbozapbo','Distance maximale entre le PBO et sa zone arriere (0 si le PBO doit etre a l interieur)','0');
INSERT INTO t_mg_va VALUES ('va_1_distsrozasro','Distance maximale entre le SRO et sa zone arriere (0 si le SRO doit etre a l interieur)','0');
INSERT INTO t_mg_va VALUES ('va_1_liv','Code de la livraison controlee','LIV0001');
INSERT INTO t_mg_va VALUES ('va_1_sfdistmaxad','Distance maximale entre le SUF et l adresse','20');
INSERT INTO t_mg_va VALUES ('va_1_srsepsg','Code EPSG du systeme de coordonnees','2154');
INSERT INTO t_mg_va VALUES ('va_1_topotol','Controles topologiques : distance maximale admissible entre deux objets du graphe planaire ','0.1');
INSERT INTO t_mg_va VALUES ('va_1_vermcd','Version de GraceTHD-MCD de la livraison sous la forme x.y.z. ','2.0.1');
COMMIT;


