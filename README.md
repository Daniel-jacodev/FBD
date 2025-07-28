# 🎓 Sistema de Gerenciamento de Pessoas e Oficinas

Este projeto é uma aplicação web simples desenvolvida com **Python**, **SQLAlchemy**, **PostgreSQL** e **Panel** para gerenciamento de **Pessoas (Alunos e Professores)** e **Oficinas**. Ele foi construído com foco educacional, aplicando conceitos de modelagem de banco de dados relacional com herança, relacionamentos N:N, e regras de negócio reais.

## 📌 Funcionalidades

### 👤 Pessoa (Aluno e Professor)
- **Consulta** com filtros por nome e/ou e-mail.
- **Inserção** com validações específicas:
  - Aluno: matrícula obrigatória (6 dígitos), data de nascimento válida e e-mail verificado.
  - Professor: pelo menos uma formação (com IRA ≥ 7) e uma experiência profissional.
- **Remoção** por ID, com exclusão em cascata de dados relacionados.

### 🏫 Oficina
- **Consulta** com filtros por título e/ou professor ministrante.
- **Inserção** de nova oficina com campos como título, descrição, limite de vagas, status, carga horária e professor responsável.
- **Remoção** de oficina por ID, com exclusão automática de dependências (aulas, avaliações, etc.).

## 🧠 Tecnologias e Ferramentas

- [Python 3.11+](https://www.python.org/)
- [Panel](https://panel.holoviz.org/)
- [SQLAlchemy](https://www.sqlalchemy.org/)
- [PostgreSQL](https://www.postgresql.org/)
- [psycopg2](https://www.psycopg.org/)
- [ERDPlus](https://erdplus.com/) (para modelagem EER)

## 💻 Como Executar Localmente

1. **Clone o repositório:**
   ```bash
   git clone https://github.com/seu-usuario/seu-repo.git
   cd seu-repo
