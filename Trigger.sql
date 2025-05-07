CREATE TABLE tipodom (
id INT PRIMARY KEY,
descricao VARCHAR(100)
);

CREATE TABLE eletrodomestico (
id INT PRIMARY KEY,
descricao VARCHAR(100)
);

CREATE TABLE auditoria_eletrodomestico (
auditoria_id INT IDENTITY(1,1) PRIMARY KEY,
eletrodomestico_id INT,
descricao VARCHAR(100),

data_modificacao DATETIME DEFAULT GETDATE(),
FOREIGN KEY (eletrodomestico_id) REFERENCES eletrodomestico(id)
);

INSERT INTO eletrodomestico (id, descricao) VALUES (1, 'geladeira');
SELECT * FROM eletrodomestico;
SELECT * FROM auditoria_eletrodomestico;

CREATE TRIGGER trg_AuditoriaEletrodomestico
ON eletrodomestico
AFTER INSERT, UPDATE, DELETE
AS
BEGIN

SET NOCOUNT ON;

IF EXISTS (SELECT * FROM inserted)
INSERT INTO auditoria_eletrodomestico (eletrodomestico_id, descricao, data_modificacao)
SELECT id, descricao, GETDATE()
FROM inserted;

IF EXISTS (SELECT * FROM deleted)
INSERT INTO auditoria_eletrodomestico (eletrodomestico_id, descricao, data_modificacao)
SELECT id, descricao, GETDATE()

FROM deleted;

END;

UPDATE eletrodomestico SET descricao = 'geladeira frost free' WHERE id = 1;

DELETE FROM eletrodomestico;

DELETE FROM auditoria_eletrodomestico;
