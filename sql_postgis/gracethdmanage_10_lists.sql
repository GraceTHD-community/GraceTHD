/*GraceTHD-Manage v0.01-alpha*/
/*Creation des tables qui vont accueillir les listes de valeurs*/
/* gracethdmanage_10_lists.sql */
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

DROP TABLE IF EXISTS l_mg_fill CASCADE;
DROP TABLE IF EXISTS l_mg_track CASCADE;
DROP TABLE IF EXISTS l_roles CASCADE;
DROP TABLE IF EXISTS l_rx_avct CASCADE;



CREATE TABLE l_mg_fill(code VARCHAR(1), libelle VARCHAR(254), definition VARCHAR(254), CONSTRAINT "l_mg_fill_pk" PRIMARY KEY (code));
CREATE TABLE l_mg_track(code INTEGER, libelle VARCHAR(254), definition VARCHAR(254), CONSTRAINT "l_mg_track_pk" PRIMARY KEY (code));
CREATE TABLE l_roles(code VARCHAR(2), libelle VARCHAR(254), definition VARCHAR(254), CONSTRAINT "l_roles_pk" PRIMARY KEY (code));
CREATE TABLE l_rx_avct(code INTEGER, libelle VARCHAR(254), definition VARCHAR(254), CONSTRAINT "l_rx_avct_pk" PRIMARY KEY (code));

