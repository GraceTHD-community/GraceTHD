/* gracethddata_32_insert_tk_tg.sql */
/* Owner : GraceTHD-Community - http://gracethd-community.github.io/ */
/* Author : stephane dot byache at aleno dot eu */
/* Rev. date : 11/07/2018 */

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

SET search_path = gracethddata, public, gracethd, pg_catalog;



INSERT INTO t_dt_tgkey VALUES ('tech', 'Technologie', NULL, '2018-06-25 23:18:00', NULL, 'aleno', NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:t', 'Technologie telecom', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:t:f', 'Technologie telecom fibre optique', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:t:c', 'Technologie telecom cuivre', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:t:x', 'Technologie telecom coaxiale', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:t:h', 'Technologie telecom hertzienne', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:e', 'Technologie electrique', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:g', 'Technologie geothermique', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:l', 'Technologie eclairage', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:t:netname', 'Technologie telecom nom du reseau', 'Pas de liste de valeurs', NULL, NULL, NULL, NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:z', 'Technologie gaz', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO t_dt_tgkey VALUES ('tech:t:f:gfuname', 'Technologie telecom fibre optique nom du GFU', 'Pas de liste de valeurs', NULL, NULL, NULL, NULL, NULL);


INSERT INTO t_dt_tag VALUES ('tech:t:f', 'FTTB', 'Fiber To The Building', 'Fibre jusqu au batiment', '2018-06-25 23:28:00', NULL, 'aleno', NULL, NULL);
INSERT INTO t_dt_tag VALUES ('tech:t:f', 'FTTC', 'Fiber To The Curb', 'Fibre jusqu au trottoir', '2018-06-25 23:28:00', NULL, 'aleno', NULL, NULL);
INSERT INTO t_dt_tag VALUES ('tech:t:f', 'FTTcab', 'Fiber To The Curb', 'Fibre jusqu au sous-repartiteur', '2018-06-25 23:28:00', NULL, 'aleno', NULL, NULL);
INSERT INTO t_dt_tag VALUES ('tech:t:f', 'FTTE', 'Fiber To The Entreprise', 'Fibre pour les entreprises', '2018-06-25 23:28:00', NULL, 'aleno', NULL, NULL);
INSERT INTO t_dt_tag VALUES ('tech:t:f', 'FTTH', 'Fiber To The Home', 'Fibre jusqu au domicile', '2018-06-25 23:28:00', NULL, 'aleno', NULL, NULL);
INSERT INTO t_dt_tag VALUES ('tech:t:f', 'FTTLA', 'Fiber To The Last Amplifier', 'Fibre jusqu au dernier amplificateur', '2018-06-25 23:28:00', NULL, 'aleno', NULL, NULL);
INSERT INTO t_dt_tag VALUES ('tech:t:f', 'FTTN', 'Fiber To The Neighbourhood', 'Fibre jusqu au quartier', '2018-06-25 23:28:00', NULL, 'aleno', NULL, NULL);
INSERT INTO t_dt_tag VALUES ('tech:t:f', 'FTTO', 'Fiber To The Office', 'Fibre jusqu au bureau - entreperises', '2018-06-25 23:28:00', NULL, 'aleno', NULL, NULL);
INSERT INTO t_dt_tag VALUES ('tech:t:f', 'FTTS', 'Fiber To The Street', 'Fibre jusqu a la rue - bâtiment', '2018-06-25 23:28:00', NULL, 'aleno', NULL, NULL);



