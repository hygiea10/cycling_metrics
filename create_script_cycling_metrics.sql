/*Create Tables for Cycling Metrics 

persons: table contains basic data that identifies the cyclist
metrics: table contains data that show stats on riding performance 

Script: Quawan Smith
Please send questions to dacodingregimen@gmail.com */


drop database if exists cycling;
create database cycling;

use cycling;

create table if not exists persons (
persons_id int not null auto_increment,
first_name varchar(250) not null,
last_name varchar(250) not null,
email_address varchar(45) null,
person_metric_id int null,
primary key (persons_id),
unique index person_metric_id_unique (person_metric_id)
);

create table if not exists metrics (
   metric_id int not null auto_increment,
   activity_type varchar (45) null,
   date_of_ride datetime null,
   favorite varchar(45) null,
   title varchar(250) null,
   distance decimal(8,2) null,
   calories decimal(8,2) null,
   duration time null,
   avg_speed decimal(8,2) null,
   max_speed decimal(8,2) null,
   elev_gain decimal(8,2) null,
   elev_loss decimal(8,2) null,
   avg_stride_length decimal(8,2) null,
   avg_vertical_ratio decimal(8,2) null,
   avg_vertical_oscillation decimal(8,2) null,
   training_stress_score varchar(45) null,
   grit decimal(8,2) null,
   flow decimal(8,2) null,
   bottom_time time null,
   min_temp decimal(8,2) null,
   surface_interval time null,
   decompression varchar(45) null,
   best_lap_time time null,
   number_of_runs int null,
   max_temp decimal(8,2) null,
   person_metric_id int null,
   primary key(metric_id),
   constraint fk_person_metric_id foreign key (person_metric_id)
   references persons (person_metric_id)
    )



