
create database Vendas_Games;
use vendas_games;
-- Criação das tabelas
DROP TABLE IF EXISTS pedidos;
DROP TABLE IF EXISTS clientes;
DROP TABLE IF EXISTS produtos;
DROP TABLE IF EXISTS funcionarios;

CREATE TABLE clientes (
    id_cliente INT PRIMARY KEY,
    nome VARCHAR(100),
    email VARCHAR(100),
    cidade VARCHAR(50)
);

CREATE TABLE produtos (
    id_produto INT PRIMARY KEY,
    nome VARCHAR(100),
    categoria VARCHAR(50),
    preco DECIMAL(10,2)
);

CREATE TABLE funcionarios (
    id_funcionario INT PRIMARY KEY,
    nome VARCHAR(100)
);

CREATE TABLE pedidos (
    id_pedido INT PRIMARY KEY,
    id_cliente INT,
    id_produto INT,
    id_funcionario INT,
    quantidade INT,
    data_pedido DATE,
    status VARCHAR(20),
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES produtos(id_produto),
    FOREIGN KEY (id_funcionario) REFERENCES funcionarios(id_funcionario)
);

-- Inserção de dados fictícios
INSERT INTO clientes VALUES
(1, 'João Silva', 'joao@email.com', 'SP'),
(2, 'Maria Oliveira', 'maria@email.com', 'RJ'),
(3, 'Carlos Souza', 'carlos@email.com', 'MG'),
(4, 'Ana Lima', 'ana@email.com', 'BA');

INSERT INTO produtos VALUES
(1, 'The Legend of Zelda', 'Nintendo Switch', 299.90),
(2, 'God of War Ragnarok', 'PS5', 349.90),
(3, 'Halo Infinite', 'Xbox', 199.90),
(4, 'FIFA 24', 'PC', 249.90),
(5, 'Mario Kart 8', 'Nintendo Switch', 279.90);

INSERT INTO funcionarios VALUES
(1, 'Fernanda Mendes'),
(2, 'Lucas Rocha');

INSERT INTO pedidos VALUES
(1, 1, 1, 1, 2, '2024-03-15', 'entregue'),
(2, 2, 2, 2, 1, '2024-03-17', 'entregue'),
(3, 3, 3, 1, 3, '2024-04-02', 'cancelado'),
(4, 4, 4, 2, 1, '2024-04-05', 'entregue'),
(5, 1, 5, 1, 2, '2024-04-10', 'entregue');

-- Total vendido por categoria
SELECT 
    produtos.categoria, 
    SUM(pedidos.quantidade * produtos.preco) AS total_vendido
FROM pedidos
JOIN produtos ON pedidos.id_produto = produtos.id_produto
WHERE pedidos.status = 'entregue'
GROUP BY produtos.categoria
ORDER BY total_vendido DESC;

-- Clientes que mais compraram
SELECT 
    clientes.nome AS cliente, 
    SUM(pedidos.quantidade * produtos.preco) AS total_gasto
FROM pedidos
JOIN clientes ON pedidos.id_cliente = clientes.id_cliente
JOIN produtos ON pedidos.id_produto = produtos.id_produto
WHERE pedidos.status = 'entregue'
GROUP BY clientes.nome
ORDER BY total_gasto DESC;

-- Produtos mais vendidos
SELECT 
    produtos.nome AS produto, 
    SUM(pedidos.quantidade) AS total_vendido
FROM pedidos
JOIN produtos ON pedidos.id_produto = produtos.id_produto
WHERE pedidos.status = 'entregue'
GROUP BY produtos.nome
ORDER BY total_vendido DESC;

-- Faturamento por mês
SELECT 
    DATE_FORMAT(data_pedido, '%Y-%m') AS mes, 
    SUM(pedidos.quantidade * produtos.preco) AS faturamento
FROM pedidos
JOIN produtos ON pedidos.id_produto = produtos.id_produto
WHERE pedidos.status = 'entregue'
GROUP BY mes
ORDER BY mes;


