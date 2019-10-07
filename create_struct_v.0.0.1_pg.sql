/*==============================================================*/
/* DBMS name:      PostgreSQL 9.x                               */
/* Created on:     07/10/2019 21.43.38                          */
/*==============================================================*/


drop index if exists PETUGAS_FOTO_FK;

drop index if exists FOTO_SEKOLAH_FK;

drop index if exists FOTO_JENIS_FK;

drop index if exists FOTO_PK;

drop table IF EXISTS  foto cascade;

drop index if exists GEOTAG_SEKOLAH_FK;

drop index if exists PETUGAS_GEOTAG_FK;

drop index if exists GEOTAG_STATUS_FK;

drop index if exists GEOTAG_PK;

drop table IF EXISTS  geotag cascade;

drop index if exists JENIS_FOTO_PK;

drop table IF EXISTS  ref.jenis_foto cascade;

drop index if exists USER_SEKOLAH_FK;

drop index if exists PENGGUNA_PK;

drop table IF EXISTS  pengguna cascade;

drop index if exists SEKOLAH_PK;

drop table IF EXISTS  sekolah cascade;

drop index if exists STATUS_GEOTAG_PK;

drop table IF EXISTS  ref.status_geotag cascade;

drop schema if exists ref;

/*==============================================================*/
/* User: ref                                                    */
/*==============================================================*/
create schema ref;

/*==============================================================*/
/* Table: foto                                                  */
/*==============================================================*/
create table foto (
   foto_id              uuid                 not null,
   jenis_foto_id        INT2                 not null,
   sekolah_id           uuid                 not null,
   pengguna_id          uuid                 not null,
   judul                VARCHAR(250)         null,
   tgl_pengambilan      DATE                 null,
   tinggi_pixel         INT4                 null,
   lebar_pixel          INT4                 null,
   ukuran               INT4                 null,
   lintang              NUMERIC(11,7)        null,
   bujur                NUMERIC(11,7)        null,
   tgl_pengiriman       DATE                 null,
   status_data          INT2                 null,
   constraint PK_FOTO primary key (foto_id)
);

/*==============================================================*/
/* Index: FOTO_PK                                               */
/*==============================================================*/
create unique index FOTO_PK on foto  (
foto_id
);

/*==============================================================*/
/* Index: FOTO_JENIS_FK                                         */
/*==============================================================*/
create  index FOTO_JENIS_FK on foto  (
jenis_foto_id
);

/*==============================================================*/
/* Index: FOTO_SEKOLAH_FK                                       */
/*==============================================================*/
create  index FOTO_SEKOLAH_FK on foto  (
sekolah_id
);

/*==============================================================*/
/* Index: PETUGAS_FOTO_FK                                       */
/*==============================================================*/
create  index PETUGAS_FOTO_FK on foto  (
pengguna_id
);

/*==============================================================*/
/* Table: geotag                                                */
/*==============================================================*/
create table geotag (
   geotag_id            uuid                 not null,
   sekolah_id           uuid                 not null,
   status_geotag_id     INT2                 not null,
   pengguna_id          uuid                 not null,
   tgl_pengambilan      DATE                 null,
   lintang              NUMERIC(11,7)        null,
   bujur                NUMERIC(11,7)        null,
   petugas_link         uuid                 null,
   sekolah_link         uuid                 null,
   tgl_pengiriman       DATE                 null,
   status_data          INT2                 null,
   constraint PK_GEOTAG primary key (geotag_id)
);

/*==============================================================*/
/* Index: GEOTAG_PK                                             */
/*==============================================================*/
create unique index GEOTAG_PK on geotag  (
geotag_id
);

/*==============================================================*/
/* Index: GEOTAG_STATUS_FK                                      */
/*==============================================================*/
create  index GEOTAG_STATUS_FK on geotag  (
status_geotag_id
);

/*==============================================================*/
/* Index: PETUGAS_GEOTAG_FK                                     */
/*==============================================================*/
create  index PETUGAS_GEOTAG_FK on geotag  (
pengguna_id
);

/*==============================================================*/
/* Index: GEOTAG_SEKOLAH_FK                                     */
/*==============================================================*/
create  index GEOTAG_SEKOLAH_FK on geotag  (
sekolah_id
);

/*==============================================================*/
/* Table: jenis_foto                                            */
/*==============================================================*/
create table ref.jenis_foto (
   jenis_foto_id        INT2                 not null,
   nama_jenis_foto      VARCHAR(140)         null,
   instruksi            TEXT                 null,
   status_isian         INT4                 null,
   constraint PK_JENIS_FOTO primary key (jenis_foto_id)
);

/*==============================================================*/
/* Index: JENIS_FOTO_PK                                         */
/*==============================================================*/
create unique index JENIS_FOTO_PK on ref.jenis_foto  (
jenis_foto_id
);

/*==============================================================*/
/* Table: pengguna                                              */
/*==============================================================*/
create table pengguna (
   pengguna_id          uuid                 not null,
   sekolah_id           uuid                 null,
   username             VARCHAR(60)          not null,
   password             VARCHAR(50)          not null,
   nama                 VARCHAR(100)         not null,
   nip_nim              VARCHAR(18)          null,
   jabatan_lembaga      VARCHAR(25)          null,
   ym                   VARCHAR(20)          null,
   skype                VARCHAR(20)          null,
   alamat               VARCHAR(80)          null,
   kode_wilayah         CHAR(8)              not null,
   no_telepon           VARCHAR(20)          null,
   no_hp                VARCHAR(20)          null,
   aktif                NUMERIC(1)           not null,
   ptk_id               VARCHAR(36)          null,
   peran_id             INT4                 not null,
   lembaga_id           VARCHAR(36)          null,
   yayasan_id           VARCHAR(36)          null,
   la_id                CHAR(5)              null,
   dudi_id              VARCHAR(36)          null,
   create_date          DATE                 not null,
   roles                TEXT                 null,
   last_update          DATE                 null,
   soft_delete          NUMERIC(1)           null,
   last_sync            DATE                 null,
   updater_id           VARCHAR(36)          null,
   constraint PK_PENGGUNA primary key (pengguna_id)
);

/*==============================================================*/
/* Index: PENGGUNA_PK                                           */
/*==============================================================*/
create unique index PENGGUNA_PK on pengguna  (
pengguna_id
);

/*==============================================================*/
/* Index: USER_SEKOLAH_FK                                       */
/*==============================================================*/
create  index USER_SEKOLAH_FK on pengguna  (
sekolah_id
);

/*==============================================================*/
/* Table: sekolah                                               */
/*==============================================================*/
create table sekolah (
   sekolah_id           uuid                 not null,
   nama                 VARCHAR(100)         not null,
   nama_nomenklatur     VARCHAR(100)         null,
   nss                  CHAR(12)             null,
   npsn                 CHAR(8)              null,
   bentuk_pendidikan_id INT2                 not null,
   alamat_jalan         VARCHAR(80)          not null,
   rt                   NUMERIC(2)           null,
   rw                   NUMERIC(2)           null,
   nama_dusun           VARCHAR(60)          null,
   desa_kelurahan       VARCHAR(60)          not null,
   kode_wilayah         CHAR(8)              not null,
   kode_pos             CHAR(5)              null,
   lintang              NUMERIC(11,7)        null,
   bujur                NUMERIC(11,7)        null,
   nomor_telepon        VARCHAR(20)          null,
   nomor_fax            VARCHAR(20)          null,
   email                VARCHAR(60)          null,
   website              VARCHAR(100)         null,
   kebutuhan_khusus_id  INT4                 not null,
   status_sekolah       NUMERIC(1)           not null,
   sk_pendirian_sekolah VARCHAR(80)          null,
   tanggal_sk_pendirian DATE                 null,
   status_kepemilikan_id NUMERIC(1)           not null,
   yayasan_id           VARCHAR(36)          null,
   sk_izin_operasional  VARCHAR(80)          null,
   tanggal_sk_izin_operasional DATE                 null,
   no_rekening          VARCHAR(20)          null,
   nama_bank            VARCHAR(20)          null,
   cabang_kcp_unit      VARCHAR(60)          null,
   rekening_atas_nama   VARCHAR(50)          null,
   mbs                  NUMERIC(1)           not null,
   luas_tanah_milik     NUMERIC(7)           not null,
   luas_tanah_bukan_milik NUMERIC(7)           not null,
   kode_registrasi      INT8                 null,
   npwp                 CHAR(15)             null,
   nm_wp                VARCHAR(100)         null,
   flag                 CHAR(3)              null,
   create_date          DATE                 null,
   last_update          DATE                 null,
   soft_delete          NUMERIC(1)           null,
   last_sync            DATE                 null,
   updater_id           VARCHAR(36)          null,
   constraint PK_SEKOLAH primary key (sekolah_id)
);

/*==============================================================*/
/* Index: SEKOLAH_PK                                            */
/*==============================================================*/
create unique index SEKOLAH_PK on sekolah  (
sekolah_id
);

/*==============================================================*/
/* Table: status_geotag                                         */
/*==============================================================*/
create table ref.status_geotag (
   status_geotag_id     INT2                 not null,
   nama_status_geotag   VARCHAR(80)          null,
   constraint PK_STATUS_GEOTAG primary key (status_geotag_id)
);

/*==============================================================*/
/* Index: STATUS_GEOTAG_PK                                      */
/*==============================================================*/
create unique index STATUS_GEOTAG_PK on ref.status_geotag  (
status_geotag_id
);

alter table  foto
   add constraint FK_FOTO_FOTO_JENI_JENIS_FO foreign key (jenis_foto_id)
      references  ref.jenis_foto (jenis_foto_id)
      on delete restrict on update restrict;

alter table  foto
   add constraint FK_FOTO_FOTO_SEKO_SEKOLAH foreign key (sekolah_id)
      references  sekolah (sekolah_id)
      on delete restrict on update restrict;

alter table  foto
   add constraint FK_FOTO_PETUGAS_F_PENGGUNA foreign key (pengguna_id)
      references  pengguna (pengguna_id)
      on delete restrict on update restrict;

alter table  geotag
   add constraint FK_GEOTAG_GEOTAG_SE_SEKOLAH foreign key (sekolah_id)
      references  sekolah (sekolah_id)
      on delete restrict on update restrict;

alter table  geotag
   add constraint FK_GEOTAG_GEOTAG_ST_STATUS_G foreign key (status_geotag_id)
      references  ref.status_geotag (status_geotag_id)
      on delete restrict on update restrict;

alter table  geotag
   add constraint FK_GEOTAG_PETUGAS_G_PENGGUNA foreign key (pengguna_id)
      references  pengguna (pengguna_id)
      on delete restrict on update restrict;

alter table  pengguna
   add constraint FK_PENGGUNA_USER_SEKO_SEKOLAH foreign key (sekolah_id)
      references  sekolah (sekolah_id)
      on delete restrict on update restrict;

