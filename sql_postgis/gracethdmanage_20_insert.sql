/*GraceTHD-Manage v0.01-alpha*/
/*Insertion des valeurs dans les listes*/
/* gracethd_20_insert.sql */
/*PostGIS*/

/* Owner : GraceTHD-Community - http://gracethd-community.github.io/ */
/* Author : stephane dot byache at aleno dot eu */
/* Rev. date : 19/08/2018 */

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

SET search_path TO gracethdmanage, gracethd, public;

BEGIN;
INSERT INTO l_mg_fill VALUES ('O','OBLIGATOIRE','');
INSERT INTO l_mg_fill VALUES ('C','CONDITIONNEL','');
INSERT INTO l_mg_fill VALUES ('F','FACULTATIF','');
INSERT INTO l_mg_fill VALUES ('N','NON DEMANDE','');
INSERT INTO l_mg_track VALUES ('0','ABANDONNE','');
INSERT INTO l_mg_track VALUES ('10','PLANIFIE','');
INSERT INTO l_mg_track VALUES ('20','PREPARATION','');
INSERT INTO l_mg_track VALUES ('30','ENVOI EN COURS','');
INSERT INTO l_mg_track VALUES ('40','DISPONIBLE','');
INSERT INTO l_mg_track VALUES ('50','INDISPONIBLE','Recepteur declare indisponible. ');
INSERT INTO l_mg_track VALUES ('60','REJETE','Recepteur refuse a la reception. ');
INSERT INTO l_mg_track VALUES ('70','RECEPTIONNE PARTIELLEMENT','Recepteur declare partiellement receptionne. ');
INSERT INTO l_mg_track VALUES ('80','RECEPTIONNE','');
INSERT INTO l_roles VALUES ('P','PROPRIETAIRE','');
INSERT INTO l_roles VALUES ('G','GESTIONNAIRE','');
INSERT INTO l_roles VALUES ('U','UTILISATEUR','');
INSERT INTO l_roles VALUES ('I','INTEGRATEUR','');
INSERT INTO l_roles VALUES ('D','FOURNISSEUR DE DONNEES','');
INSERT INTO l_rx_avct VALUES ('0','ABANDONNE','Projet abandonne. ');
INSERT INTO l_rx_avct VALUES ('10','PLANIFIE','Projet planifié, non démarré. ');
INSERT INTO l_rx_avct VALUES ('20','ANALYSE','Selon les process et semantiques, on peut parler de schema de directeur. ');
INSERT INTO l_rx_avct VALUES ('23','ANALYSE STOPEE','Analyse stopee. ');
INSERT INTO l_rx_avct VALUES ('25','ANALYSE REPRISE','Reprise d analyse. ');
INSERT INTO l_rx_avct VALUES ('28','ANALYSE VALIDEE PARTIELLEMENT','Validation partielle de l etude. ');
INSERT INTO l_rx_avct VALUES ('29','ANALYSE VALIDEE','Selon les process et semantiques, il peut s agir de schema de directeur. ');
INSERT INTO l_rx_avct VALUES ('30','CONCEPTION','Selon les contextes la notion de conception pourra correspondre a un APS, etc.');
INSERT INTO l_rx_avct VALUES ('33','CONCEPTION STOPEE','Analyse stopee. ');
INSERT INTO l_rx_avct VALUES ('35','CONCEPTION REPRISE','Reprise d analyse. ');
INSERT INTO l_rx_avct VALUES ('38','CONCEPTION VALIDEE PARTIELLEMENT','Validation partielle de l etude. ');
INSERT INTO l_rx_avct VALUES ('39','CONCEPTION VALIDEE','');
INSERT INTO l_rx_avct VALUES ('40','EXECUTION','Selon les contextes la notion d execution pourra correspondre a APD, EXE, etc. ');
INSERT INTO l_rx_avct VALUES ('43','EXECUTION STOPEE','');
INSERT INTO l_rx_avct VALUES ('45','EXECUTION REPRISE','');
INSERT INTO l_rx_avct VALUES ('48','EXECUTION VALIDEE PARTIELLEMENT','');
INSERT INTO l_rx_avct VALUES ('49','EXECUTION VALIDEE','');
INSERT INTO l_rx_avct VALUES ('50','TRAVAUX','');
INSERT INTO l_rx_avct VALUES ('51','TRAVAUX PLANIFIES','');
INSERT INTO l_rx_avct VALUES ('52','TRAVAUX EN COURS','');
INSERT INTO l_rx_avct VALUES ('53','TRAVAUX STOPES','');
INSERT INTO l_rx_avct VALUES ('54','TRAVAUX A RECETTER','');
INSERT INTO l_rx_avct VALUES ('55','TRAVAUX EN COURS DE RECETTE','');
INSERT INTO l_rx_avct VALUES ('56','TRAVAUX A REPRENDRE','Non valide, reprises demandees. Voir code 60. ');
INSERT INTO l_rx_avct VALUES ('57','TRAVAUX PARTIELLEMENT RECETTES','');
INSERT INTO l_rx_avct VALUES ('58','TRAVAUX RECETTES AVEC RESERVES','');
INSERT INTO l_rx_avct VALUES ('59','TRAVAUX RECETTES','');
INSERT INTO l_rx_avct VALUES ('60','REPRISE TRAVAUX','');
INSERT INTO l_rx_avct VALUES ('61','REPRISE TRAVAUX PLANIFIES','');
INSERT INTO l_rx_avct VALUES ('62','REPRISE TRAVAUX EN COURS','');
INSERT INTO l_rx_avct VALUES ('63','REPRISE TRAVAUX STOPES','');
INSERT INTO l_rx_avct VALUES ('64','REPRISE TRAVAUX A RECETTER','');
INSERT INTO l_rx_avct VALUES ('65','REPRISE TRAVAUX EN COURS DE RECETTE','');
INSERT INTO l_rx_avct VALUES ('66','REPRISE TRAVAUX A REPRENDRE','');
INSERT INTO l_rx_avct VALUES ('67','REPRISE TRAVAUX PARTIELLEMENT RECETTES','');
INSERT INTO l_rx_avct VALUES ('68','REPRISE TRAVAUX RECETTES AVEC RESERVES','');
INSERT INTO l_rx_avct VALUES ('69','REPRISE TRAVAUX RECETTES','');
INSERT INTO l_rx_avct VALUES ('80','RECOLEMENT','');
INSERT INTO l_rx_avct VALUES ('83','RECOLEMENT STOPPE','');
INSERT INTO l_rx_avct VALUES ('88','RECOLEMENT VALIDE PARTIELLEMENT','');
INSERT INTO l_rx_avct VALUES ('89','RECOLEMENT RECETTE','');

COMMIT;
