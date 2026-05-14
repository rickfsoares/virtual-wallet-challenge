# 💰 Virtual Wallet API - Rails 8

Este projeto é uma API de Carteira Virtual desenvolvida para o desafio técnico da **ilkli**. A aplicação permite gerenciar transações financeiras (crédito e débito), consultar saldo em tempo real e visualizar extratos detalhados.

## 🛠️ Tecnologias e Decisões Técnicas

* **Ruby 3.2.5 & Rails 8.0**: Utilização da versão mais recente do framework, aproveitando recursos como o servidor **Thruster** para performance.
* **PostgreSQL 15**: Escolhido pela robustez e suporte nativo a tipos decimais, garantindo precisão em cálculos monetários.
* **Docker & Docker Compose**: O projeto foi totalmente containerizado para garantir que rode em qualquer ambiente (Windows, Mac ou Linux) sem necessidade de instalar dependências locais.
* **Arquitetura REST**: Endpoints organizados sob o namespace `api/v1` para facilitar versões futuras.

---

## 🚀 Como Executar o Projeto

Certifique-se de ter o **Docker** instalado em sua máquina.

1.  **Clone o repositório:**
    ```bash
    git clone <seu-link-do-github>
    cd wallet_challenge
    ```

2.  **Suba os containers:**
    ```bash
    docker compose up --build
    ```
    *Este comando irá buildar as imagens, instalar as gems e preparar o banco de dados (migrações e sementes) automaticamente.*

3.  **Acesse a API:**
    A aplicação estará disponível em `http://localhost:3000`.

---

## 📡 Endpoints da API

### 1. Consultar Saldo
Retorna o saldo atual acumulado do usuário.
* **URL:** `GET /api/v1/users/:user_id/balance`
* **Sucesso:** `200 OK` com `{ "balance": 150.00 }`

### 2. Criar Transação (Crédito ou Débito)
Adiciona um valor à carteira.
* **URL:** `POST /api/v1/users/:user_id/entries`
* **Body (JSON):**
    ```json
    {
      "amount": 100.50,
      "entry_type": "credit",
      "description": "Depósito via PIX"
    }
    ```

### 3. Consultar Extrato
Lista as transações em um período determinado.
* **URL:** `GET /api/v1/users/:user_id/entries?start_date=2026-01-01&end_date=2026-12-31`
* **Sucesso:** `200 OK` com a lista de transações em JSON.

---

## 🧪 Testes Automatizados

Para garantir a integridade dos cálculos de saldo e validações de modelo, execute:

```bash
docker compose exec web bin/rails test
