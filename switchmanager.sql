-- phpMyAdmin SQL Dump
-- version 2.9.1.1-Debian-6
-- http://www.phpmyadmin.net
-- 
-- Host: localhost
-- Generation Time: Dec 24, 2007 at 03:13 PM
-- Server version: 5.0.32
-- PHP Version: 5.2.0-8+etch7
-- 
-- Database: `switchmanager`
-- 

-- --------------------------------------------------------

-- 
-- Table structure for table `auth`
-- 

CREATE TABLE `auth` (
  `ID` int(11) NOT NULL auto_increment,
  `username` varchar(64) NOT NULL,
  `password` varchar(64) NOT NULL,
  `admin` int(11) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- 
-- Dumping data for table `auth`
-- 

INSERT INTO `auth` (`ID`, `username`, `password`, `admin`) VALUES 
(1, 'admin', '7da71beaf8dca8715a4152f879563ed0', 1),
(2, 'user', 'ee11cbb19052e40b07aac0ca060c23ee', 0),
(3, 'admin2', '473405e1cc52a9f5c90ca83d959910aa', 1);

-- --------------------------------------------------------

-- 
-- Table structure for table `changelog`
-- 

CREATE TABLE `changelog` (
  `ID` bigint(20) NOT NULL auto_increment,
  `DEVICE_ID` int(11) NOT NULL,
  `timestamp` int(11) NOT NULL,
  `AUTH_ID` int(11) NOT NULL,
  `UID` varchar(255) NOT NULL,
  `ifIndex` int(11) NOT NULL,
  `old_value` varchar(255) NOT NULL,
  `new_value` varchar(255) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

-- 
-- Dumping data for table `changelog`
-- 


-- --------------------------------------------------------

-- 
-- Table structure for table `devices`
-- 

CREATE TABLE `devices` (
  `ID` int(11) NOT NULL auto_increment,
  `hostname` varchar(128) NOT NULL,
  `ipaddress` varchar(15) NOT NULL,
  `description` varchar(255) NOT NULL,
  `min_days_last_input` int(11) NOT NULL,
  `snmp_rw` int(11) NOT NULL,
  `snmp_community` varchar(12) NOT NULL,
  `system_ios` int(11) NOT NULL,
  `system_uptime` varchar(128) NOT NULL,
  `system_version` varchar(128) NOT NULL,
  `system_location` varchar(128) NOT NULL,
  `is2900` int(11) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `hostname` (`hostname`,`ipaddress`),
  KEY `snmp_rw` (`snmp_rw`),
  KEY `snmp_community` (`snmp_community`,`system_ios`),
  KEY `min_days_last_input` (`min_days_last_input`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

-- 
-- Dumping data for table `devices`
-- 

INSERT INTO `devices` (`ID`, `hostname`, `ipaddress`, `description`, `min_days_last_input`, `snmp_rw`, `snmp_community`, `system_ios`, `system_uptime`, `system_version`, `system_location`, `is2900`) VALUES 
(1, 'kitchencisco', '192.168.30.3', 'cisco 2950', 7, 1, 'test', 0, '', '', '', 1),
(2, 'catoshostname', '192.168.30.3', 'catosdescription', 7, 1, 'test123', 0, '', '', '', 0),
(3, 'cpixel-router', '216.179.194.2', 'testdescrip', 7, 1, 'test123', 1, '', '', '', 0);

-- --------------------------------------------------------

-- 
-- Table structure for table `devices_oid`
-- 

CREATE TABLE `devices_oid` (
  `ID` int(11) NOT NULL auto_increment,
  `DEVICE_ID` int(11) NOT NULL,
  `OID_ID` int(11) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `DEVICE_ID` (`DEVICE_ID`,`OID_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=20 ;

-- 
-- Dumping data for table `devices_oid`
-- 

INSERT INTO `devices_oid` (`ID`, `DEVICE_ID`, `OID_ID`) VALUES 
(1, 1, 1),
(3, 1, 3),
(4, 1, 4),
(5, 1, 5),
(6, 1, 7),
(7, 1, 8),
(8, 1, 9),
(9, 1, 10),
(10, 2, 1),
(11, 2, 2),
(12, 2, 3),
(13, 2, 4),
(14, 2, 5),
(15, 2, 8),
(16, 2, 11),
(17, 2, 12),
(18, 1, 13),
(19, 2, 13);

-- --------------------------------------------------------

-- 
-- Table structure for table `locks`
-- 

CREATE TABLE `locks` (
  `ID` int(11) NOT NULL auto_increment,
  `UID` varchar(64) NOT NULL,
  `AUTH_ID` int(11) NOT NULL,
  `TIMESTAMP` int(11) NOT NULL,
  `IP` varchar(15) NOT NULL,
  `description` varchar(128) NOT NULL,
  `hits` bigint(20) NOT NULL,
  PRIMARY KEY  (`ID`),
  UNIQUE KEY `UID` (`UID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=30 ;

-- 
-- Dumping data for table `locks`
-- 

INSERT INTO `locks` (`ID`, `UID`, `AUTH_ID`, `TIMESTAMP`, `IP`, `description`, `hits`) VALUES 
(29, 'device.1', 1, 1198520103, '192.168.30.238', 'devices lock', 3);

-- --------------------------------------------------------

-- 
-- Table structure for table `oid_values`
-- 

CREATE TABLE `oid_values` (
  `ID` int(11) NOT NULL auto_increment,
  `OID_ID` int(11) NOT NULL,
  `key1` varchar(16) NOT NULL,
  `value_desc` varchar(64) NOT NULL,
  PRIMARY KEY  (`ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=12 ;

-- 
-- Dumping data for table `oid_values`
-- 

INSERT INTO `oid_values` (`ID`, `OID_ID`, `key1`, `value_desc`) VALUES 
(1, 10, '1', '1: full'),
(2, 10, '2', '2:half'),
(3, 10, '3', '3:auto'),
(4, 12, '1', '1:half'),
(5, 12, '2', '2:full'),
(6, 12, '3', '3:disable'),
(7, 12, '4', '4:auto'),
(8, 9, '1', 'autoDetect'),
(9, 9, '10000000', '10Mbit'),
(10, 9, '100000000', '100Mbit'),
(11, 9, '155520000', 's155520000');

-- --------------------------------------------------------

-- 
-- Table structure for table `oids`
-- 

CREATE TABLE `oids` (
  `ID` int(11) NOT NULL auto_increment,
  `scanner` int(11) NOT NULL default '1',
  `UID` varchar(128) NOT NULL,
  `mib_name` varchar(128) NOT NULL,
  `mib_desc` text NOT NULL,
  `oid` varchar(255) NOT NULL,
  `oid_type` char(2) NOT NULL,
  PRIMARY KEY  (`ID`),
  KEY `oid` (`oid`,`oid_type`),
  KEY `mib_name` (`mib_name`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=14 ;

-- 
-- Dumping data for table `oids`
-- 

INSERT INTO `oids` (`ID`, `scanner`, `UID`, `mib_name`, `mib_desc`, `oid`, `oid_type`) VALUES 
(1, 1, 'ifName', 'ifName', 'use this to get mod/num for portName (descri) indexing on catOS', '.1.3.6.1.2.1.31.1.1.1.1', 's'),
(2, 1, 'ifAlias', 'portName', 'catOS only\r\n\r\nthis is indexed differently.\r\nneeds to be value obtained from ifName.index = "7/2" ... 1.3.6.1.4.1.9.5.1.4.1.1.4.[7.2]', '1.3.6.1.4.1.9.5.1.4.1.1.4', 's'),
(3, 1, 'ifDesc', 'ifDesc', 'Fasthethernet0/0 etc\r\n', '.1.3.6.1.2.1.2.2.1.2', 's'),
(4, 1, 'ifAdminStatus', 'ifAdminStatus', '1 : up\r\n2 : down\r\n3 : testing', '.1.3.6.1.2.1.2.2.1.7', 'i'),
(5, 1, 'ifOperStatus', 'ifOperStatus', '1 : up\r\n2 : down\r\n3 : testing\r\n4 : unknown\r\n5 : dormant\r\n6 : notPresent\r\n7 : lowerLayerDown', '1.3.6.1.2.1.2.2.1.8', 'i'),
(6, 1, 'sysDescr', 'sysDescr', 'description of operating system', '.1.3.6.1.2.1.1.1.0', 's'),
(7, 1, 'ifAlias', 'ifAlias', 'IOS port description', '1.3.6.1.2.1.31.1.1.1.18', 's'),
(8, 1, 'vmVlan', 'vmVlan', 'vlan id associated with port', '1.3.6.1.4.1.9.9.68.1.2.2.1.2', 'i'),
(9, 1, 'portAdminSpeed', 'c2900PortAdminSpeed', '1 : autoDetect\r\n10000000 : s10000000\r\n100000000 : s100000000\r\n155520000 : s155520000', '1.3.6.1.4.1.9.9.87.1.4.1.1.33.0', 'i'),
(10, 1, 'portDuplex', 'c2900PortDuplexState', '1 : fullduplex\r\n2 : halfduplex\r\n3 : autoNegotiate', '1.3.6.1.4.1.9.9.87.1.4.1.1.31.0', 'i'),
(11, 1, 'portAdminSpeed', 'portAdminSpeed', '1 : autoDetect\r\n2 : autoDetect10100\r\n10 : s10G\r\n64000 : s64000\r\n1544000 : s1544000\r\n2000000 : s2000000\r\n2048000 : s2048000\r\n4000000 : s4000000\r\n10000000 : s10000000\r\n16000000 : s16000000\r\n45000000 : s45000000\r\n64000000 : s64000000\r\n100000000 : s100000000\r\n155000000 : s155000000\r\n400000000 : s400000000\r\n622000000 : s622000000\r\n1000000000 : s1000000000', '.1.3.6.1.4.1.9.5.1.4.1.1.9', 'i'),
(12, 1, 'portDuplex', 'portDuplex', '1 : half\r\n2 : full\r\n3 : disagree\r\n4 : auto', '1.3.6.1.4.1.9.5.1.4.1.1.10', 'i'),
(13, 0, 'ifLastChange', 'ifLastChange', 'Timetickets value of last input/out seen on interface', '.1.3.6.1.2.1.2.2.1.9', 'i');

-- --------------------------------------------------------

-- 
-- Table structure for table `queue`
-- 

CREATE TABLE `queue` (
  `ID` int(11) NOT NULL auto_increment,
  `DEVICE_ID` int(11) NOT NULL,
  `OID_ID` int(11) NOT NULL,
  `new_value` varchar(255) NOT NULL,
  `submit_time` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `set_time` timestamp NOT NULL default '0000-00-00 00:00:00',
  PRIMARY KEY  (`ID`),
  KEY `DEVICE_ID` (`DEVICE_ID`,`OID_ID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

-- 
-- Dumping data for table `queue`
-- 

INSERT INTO `queue` (`ID`, `DEVICE_ID`, `OID_ID`, `new_value`, `submit_time`, `set_time`) VALUES 
(1, 0, 0, 'newdescrip', '2007-12-22 22:24:44', '0000-00-00 00:00:00');
