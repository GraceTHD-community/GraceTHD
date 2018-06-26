/* gracethddata_32_insert_tk_tg.sql */
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

/*Spatialite*/

--SET search_path = gracethddata, public, gracethd, pg_catalog;

INSERT INTO t_dt_tgkey VALUES 
('tech','Techologie',NULL,'2018-06-25 23:18:00',NULL,'aleno',NULL,NULL),
('tech:tfo','Techologie telecom fibre',NULL,'2018-06-25 23:18:00',NULL,'aleno',NULL,NULL),
('tech:thz','Techologie telecom hertzienne',NULL,'2018-06-25 23:18:00',NULL,'aleno',NULL,NULL),
('tech:tcx','Techologie telecom coaxiale',NULL,'2018-06-25 23:18:00',NULL,'aleno',NULL,NULL),
('tech:tcu','Techologie telecom cuivre',NULL,'2018-06-25 23:18:00',NULL,'aleno',NULL,NULL)
;

INSERT INTO t_dt_tag VALUES
('tech:tfo','FTTN','Fiber To The Neighbourhood','Fibre jusqu au quartier','2018-06-25 23:28:00',NULL,'aleno',NULL,NULL),
('tech:tfo','FTTC','Fiber To The Curb','Fibre jusqu au trottoir','2018-06-25 23:28:00',NULL,'aleno',NULL,NULL),
('tech:tfo','FTTS','Fiber To The Street','Fibre jusqu a la rue - bâtiment','2018-06-25 23:28:00',NULL,'aleno',NULL,NULL),
--('tech:tfo','FTTN','Fiber To The Node',NULL,'2018-06-25 23:28:00','Fibre jusqu au repartiteur','aleno',NULL,NULL),
('tech:tfo','FTTB','Fiber To The Building','Fibre jusqu au batiment','2018-06-25 23:28:00',NULL,'aleno',NULL,NULL),
('tech:tfo','FTTcab','Fiber To The Curb','Fibre jusqu au sous-repartiteur','2018-06-25 23:28:00',NULL,'aleno',NULL,NULL),
('tech:tfo','FTTH','Fiber To The Home','Fibre jusqu au domicile','2018-06-25 23:28:00',NULL,'aleno',NULL,NULL),
('tech:tfo','FTTE','Fiber To The Entreprise','Fibre pour les entreprises','2018-06-25 23:28:00',NULL,'aleno',NULL,NULL),
('tech:tfo','FTTO','Fiber To The Office','Fibre jusqu au bureau - entreperises','2018-06-25 23:28:00',NULL,'aleno',NULL,NULL),
('tech:tfo','FTTLA','Fiber To The Last Amplifier','Fibre jusqu au dernier amplificateur','2018-06-25 23:28:00',NULL,'aleno',NULL,NULL)
;

INSERT INTO t_dt_tgkey_user VALUES 
('usr','Cle utilisateur','Toutes les cles utilisateurs doivent commencer par usr:','2018-06-25 23:18:00',NULL,'aleno',NULL,NULL)
;
