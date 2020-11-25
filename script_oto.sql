drop database if exists oto;

create database oto default character set utf8;

use oto;

create table clients(
    cli_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cli_nom varchar(50) not null, 
    cli_prenom varchar(50) not null, 
    cli_adresse varchar(150), 
    cli_tel varchar(10) not null, 
    cli_mail varchar(30), 
    cli_mdp varchar(30) not null, 
    cli_date_inscr date
    ) ENGINE=InnoDB;

create table marques(
    marque_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    marque_nom varchar(50) not null
    ) ENGINE=InnoDB;

create table modeles(
    mod_id int NOT NULL AUTO_INCREMENT PRIMARY KEY,
    mod_nom varchar(50) not null, 
    marque_id int,
    foreign key(marque_id) references marques(marque_id)
    ) ENGINE=InnoDB;

create table posts(
    post_nom varchar(50) not null, 
    post_id int NOT NULL AUTO_INCREMENT PRIMARY KEY
    ) ENGINE=InnoDB;

create table fournisseurs(
    fo_nom varchar(50) not null, 
    fo_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    fo_adresse varchar(150) not null, 
    fo_tel varchar(10) not null, 
    fo_mail varchar(30)
    ) ENGINE=InnoDB;

create table vehicules(
    ve_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    ve_prix decimal(7.2) not null, 
    ve_ean varchar(20) not null, 
    ve_desc text(150), 
    ve_couleur varchar(10) not null, 
    ve_foto varchar(50), 
    ve_stock_ph int not null, 
    ve_stock_alert int not null, 
    ve_ref varchar(50), 
    fo_id int,
    mod_id int,
    FOREIGN KEY (fo_id) REFERENCES fournisseurs(fo_id),
    FOREIGN KEY (mod_id) REFERENCES modeles(mod_id)
    ) ENGINE=InnoDB;

create table accessoires(
    acc_nom varchar(50), 
    acc_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    acc_prix decimal(7.2) not null,
    acc_ref varchar(50), 
    acc_ean varchar(20) not null, 
    acc_stock_ph int not null,
    acc_stock_alert int not null, 
    acc_couleur varchar(10)not null, 
    acc_desc text(150),
    acc_foto varchar(50),
    fo_id int,
    FOREIGN KEY (fo_id) REFERENCES fournisseurs(fo_id)
    ) ENGINE=InnoDB;

create table salaries(
    sal_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    sal_nom varchar(50) not null, 
    sal_prenom varchar(50) not null, 
    sal_salaire decimal(7.2) not null, 
    sal_sexe varchar(10) not null, 
    sal_date_entre date not null, 
    sal_tel varchar(10) not null, 
    sal_adresse varchar(150) not null, 
    post_id int,
    FOREIGN KEY (post_id) REFERENCES posts(post_id)
    ) ENGINE=InnoDB;

create table services(
    ser_nom varchar(50) not null, 
    ser_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    sal_id int,
    FOREIGN KEY (sal_id) REFERENCES salaries(sal_id)
    ) ENGINE=InnoDB;

create table commandes(
    com_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    com_date date not null, 
    com_pay_date date,
    com_livr_date date, 
    cli_id int, 
    sal_id int,
    FOREIGN KEY (cli_id) REFERENCES clients(cli_id),
    FOREIGN KEY (sal_id) REFERENCES salaries(sal_id)
    ) ENGINE=InnoDB;

create table commandes_details(
    comdet_id int NOT NULL AUTO_INCREMENT PRIMARY KEY, 
    prix_unite decimal(7.2) not null, 
    quantite int not null, 
    reduc decimal(7.2),
    prix_commande decimal(7.2) not null, 
    com_id int, 
    acc_id int,
    ve_id int, 
    ser_id int,
    FOREIGN KEY (com_id) REFERENCES commandes(com_id),
    FOREIGN KEY (acc_id) REFERENCES accessoires(acc_id),
    FOREIGN KEY (ve_id) REFERENCES vehicules(ve_id),
    FOREIGN KEY (ser_id) REFERENCES services(ser_id)
    ) ENGINE=InnoDB;
