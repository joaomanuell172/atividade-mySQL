
 Criar o banco de dados
CREATE DATABASE IF NOT EXISTS TechStore;
USE TechStore;

Remover tabelas se existirem (na ordem inversa das chaves estrangeiras)
DROP TABLE IF EXISTS Pedidos;
DROP TABLE IF EXISTS Produtos;
DROP TABLE IF EXISTS Clientes;

  Criar Tabela 
CREATE TABLE Clientes (
    id_cliente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    cidade VARCHAR(50)
);

CREATE TABLE Produtos (
    id_produto INT PRIMARY KEY AUTO_INCREMENT,
    nome_produto VARCHAR(100) NOT NULL,
    categoria VARCHAR(50),
    preco DECIMAL(10, 2) NOT NULL,
    estoque INT DEFAULT 0
);

-- Criar Tabela de Pedidos (Relacionamento entre Clientes e Produtos)
CREATE TABLE Pedidos (
    id_pedido INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    id_produto INT,
    data_pedido DATE,
    quantidade INT,
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES Produtos(id_produto)
);

-- 2. DML - MANIPULAÇÃO DE DADOS

-- Inserindo dados iniciais
INSERT INTO Clientes (nome, email, cidade) VALUES 
('Alice Oliveira', 'alice@email.com', 'Salvador'),
('Roberto Costa', 'roberto@email.com', 'São Paulo'),
('Mariana Souza', 'mari@email.com', 'Belo Horizonte');

INSERT INTO Produtos (nome_produto, categoria, preco, estoque) VALUES 
('Smartphone Galaxy', 'Eletrônicos', 2500.00, 15),
('Teclado Mecânico', 'Periféricos', 350.00, 30),
('Headset Gamer', 'Áudio', 480.00, 20);

-- Registrando pedidos (DML - INSERT)
INSERT INTO Pedidos (id_cliente, id_produto, data_pedido, quantidade) VALUES 
(1, 1, CURDATE(), 1),  
(2, 2, CURDATE(), 2),  
(1, 3, CURDATE(), 1);  

-- Atualizando preço de um produto (DML - UPDATE)
UPDATE Produtos 
SET preco = 320.00 
WHERE nome_produto = 'Teclado Mecânico';

-- Excluindo um cliente que não possui pedidos 
DELETE FROM Clientes 
WHERE nome = 'Mariana Souza';

-- Relatório completo: Quem comprou o quê, valor unitário e total por item
SELECT 
    P.id_pedido AS 'ID',
    C.nome AS 'Cliente',
    PR.nome_produto AS 'Produto',
    P.quantidade AS 'Qtd',
    PR.preco AS 'Preço Unit.',
    (P.quantidade * PR.preco) AS 'Valor Total'
FROM Pedidos P
INNER JOIN Clientes C ON P.id_cliente = C.id_cliente
INNER JOIN Produtos PR ON P.id_produto = PR.id_produto
ORDER BY C.nome;
