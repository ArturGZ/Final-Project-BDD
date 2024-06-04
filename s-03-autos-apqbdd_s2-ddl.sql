-- @Autor: Arturo Pérez Quintana
-- @Fecha:2/06/2024
-- @Descripcion: Creación de objetos para Nodo 4 - apqbdd_s2

-- TABLE: AUTO_F1_APQ_S2 
CREATE TABLE AUTO_F1_APQ_S2(
    AUTO_ID    NUMBER(10, 0)    NOT NULL,
    FOTO       BLOB             NOT NULL,
    CONSTRAINT AUTO_F1_PK PRIMARY KEY (AUTO_ID)
)
;

-- TABLE: CLIENTE_F3_APQ_S2 
CREATE TABLE CLIENTE_F3_APQ_S2(
    CLIENTE_ID            NUMBER(10, 0)    NOT NULL,
    NOMBRE                VARCHAR2(40)     NOT NULL,
    AP_PATERNO            VARCHAR2(40)     NOT NULL,
    AP_MATERNO            VARCHAR2(40),
    NUM_IDENTIFICACION    VARCHAR2(18)     NOT NULL,
    EMAIL                 VARCHAR2(500)    NOT NULL,
    CONSTRAINT CLIENTE_F3_PK PRIMARY KEY (CLIENTE_ID)
)
;

-- TABLE: STATUS_AUTO 
CREATE TABLE STATUS_AUTO(
    STATUS_AUTO_ID    NUMBER(2, 0)    NOT NULL,
    CLAVE             VARCHAR2(20)    NOT NULL,
    DESCRIPCION       VARCHAR2(40)    NOT NULL,
    CONSTRAINT STATUS_AUTO_S4_PK PRIMARY KEY (STATUS_AUTO_ID)
)
;

-- TABLE: HISTORICO_STATUS_AUTO_F1_APQ_S2 
CREATE TABLE HISTORICO_STATUS_AUTO_F1_APQ_S2(
    HISTORICO_STATUS_ID    NUMBER(10, 0)     NOT NULL,
    FECHA_STATUS           DATE,
    STATUS_AUTO_ID         NUMBER(2, 0)     NOT NULL,
    AUTO_ID                NUMBER(10, 0)    NOT NULL,
    CONSTRAINT HISTORICO_STATUS_AUTO_F1_PK PRIMARY KEY (HISTORICO_STATUS_ID), 
    CONSTRAINT AUTO_F1_HISTORICO_F1_AUTO_ID_FK FOREIGN KEY (AUTO_ID)
    REFERENCES AUTO_F1_APQ_S2(AUTO_ID),
    CONSTRAINT STATUS_AUTO_HISTORICO_F1_STATUS_ID_FK FOREIGN KEY (STATUS_AUTO_ID)
    REFERENCES STATUS_AUTO(STATUS_AUTO_ID)
)
;

-- TABLE: MARCA_R_APQ_S2 
CREATE TABLE MARCA_R_APQ_S2(
    MARCA_ID       NUMBER(10, 0)    NOT NULL,
    CLAVE          VARCHAR2(50)     NOT NULL,
    DESCRIPCION    VARCHAR2(500)    NOT NULL,
    ACTIVO         NUMBER(1, 0)     NOT NULL,
    CONSTRAINT MARCA_R4_PK PRIMARY KEY (MARCA_ID)
)
;

-- TABLE: MODELO_R_APQ_S2 
CREATE TABLE MODELO_R_APQ_S2(
    MODELO_ID      NUMBER(10, 0)    NOT NULL,
    CLAVE          VARCHAR2(50)     NOT NULL,
    DESCRIPCION    VARCHAR2(500)    NOT NULL,
    ACTIVO         NUMBER(1, 0)     NOT NULL,
    MARCA_ID       NUMBER(10, 0)    NOT NULL,
    CONSTRAINT MODELO_R4_PK PRIMARY KEY (MODELO_ID), 
    CONSTRAINT MARCA_R4_MODELO_R4_FK FOREIGN KEY (MARCA_ID)
    REFERENCES MARCA_R_APQ_S2(MARCA_ID)
)
;

-- TABLE: PAGO_AUTO_F3_APQ_S2 
CREATE TABLE PAGO_AUTO_F3_APQ_S2(
    CLIENTE_ID     NUMBER(10, 0)    NOT NULL,
    AUTO_ID        NUMBER(10, 0)    NOT NULL,
    FECHA_PAGO     DATE             NOT NULL,
    IMPORTE        NUMBER(8, 2)     NOT NULL,
    RECIBO_PAGO    BLOB             NOT NULL,
    CONSTRAINT PAGO_AUTO_F3_PK PRIMARY KEY (CLIENTE_ID, AUTO_ID), 
    CONSTRAINT CLIENTE_F3_PAGO_AUTO_F3_CLIENTE_ID_FK FOREIGN KEY (CLIENTE_ID)
    REFERENCES CLIENTE_F3_APQ_S2(CLIENTE_ID),
    CONSTRAINT AUTO_F1_PAGO_AUTO_F3_AUTO_ID_FK FOREIGN KEY (AUTO_ID)
    REFERENCES AUTO_F1_APQ_S2(AUTO_ID)
)
;