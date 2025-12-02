# 🚀 DMS - Delivery Management System

## Visão Geral do Projeto

O DMS é uma plataforma completa de **logística urbana em tempo real** e **multilocatário (multi-tenant SaaS)**. O propósito central é capacitar empresas (tenants) a gerenciar toda a sua cadeia de entregas, desde a alocação do entregador mais próximo até o controle financeiro e incentivos.

A plataforma se destaca por:
* Gerenciamento de frotas próprias e entregadores terceirizados.
* Acompanhamento de entregas em tempo real.
* Sistema de Billing em duas camadas (Plataforma → Tenant e Tenant → Entregadores).

## 🎯 Público Alvo

| Papel | Foco |
| :--- | :--- |
| **Tenants (Empresas)** | Lojas, Restaurantes, Transportadoras urbanas. |
| **Entregadores** | Motociclistas, Ciclistas, Motoristas autônomos. |
| **SuperAdmin** | Gestão global e financeira da plataforma DMS (SaaS). |

## ⚙️ Arquitetura Tecnológica

O DMS é construído com foco em alta concorrência, escalabilidade e tempo real, utilizando a arquitetura **Umbrella** do Elixir.

### Stack Principal
| Tecnologia | Uso |
| :--- | :--- |
| **Elixir / Phoenix** | Core do sistema, Web, API e Channels. |
| **Phoenix Live View** | Dashboards e Mapas em tempo real (Realtime). |
| **Ecto + PostgreSQL** | Persistência de dados. |
| **Geo/PostGIS** | Cálculos de Geolocalização e Matching de Entregadores. |
| **Oban** | Jobs assíncronos (Billing, Cálculo de Ranking, Cobrança). |
| **Guardian/JWT** | Autenticação mobile segura para entregadores. |

### Módulos Umbrella
A modularização em Umbrella garante a separação de responsabilidades:
* `dms_identity`: Gerenciamento de Tenants, Usuários, Entregadores e Autenticação.
* `dms_core`: Lógica principal de Entregas, Logística, Ranking e SOS.
* `dms_payments`: Carteiras, Assinaturas (SaaS e Interna) e Repasses (Pix).
* `dms_realtime`: Geolocalização, Channels e Notificações real-time.
* `dms_web`: Interface Web e API REST.

## ✨ Funcionalidades Chave

### Para o Tenant (Empresa)
* **Gestão Completa de Entregadores**.
* **Tracking em Tempo Real** no mapa (LiveView).
* **Billing Interno:** Criação e cobrança de planos de assinatura dos entregadores.
* **Gamificação:** Criação de desafios e ranking para incentivar a frota.

### Para o Entregador
* **Autenticação JWT** para aplicativo mobile.
* **Carteira Digital** para recebimento e saques (Pix).
* **Sistema SOS** para ajuda entre entregadores.
* **Ranking** e acompanhamento de desafios.

## 🗺️ Roadmap de Sprints (12 Sprints)

O projeto está dividido em 12 Sprints de 3 semanas, cobrindo o ciclo completo do produto:

1.  **Fundação e Identity:** Estrutura Umbrella e Multi-tenant.
2.  **Billing SaaS:** Assinatura e suspensão automática de Tenants.
3.  **Gestão de Entregadores:** CRUD e Autenticação Mobile (JWT).
4.  **Geolocalização:** Mapa em tempo real para o Tenant.
5.  **Core Logístico:** Matching, fluxo de entrega e status.
6.  **Sistema SOS:** Ajuda entre entregadores e transferência de entrega.
7.  **Gamificação:** Ranking e Desafios.
8.  **Carteira Digital:** Wallet e Saques (Pix).
9.  **Assinaturas Internas:** Billing dos Entregadores pelo Tenant.
10. **Dashboards:** Visão operacional e financeira para todos os usuários.
11. **Integrações Externas:** API Pública e Webhooks.
12. **Qualidade e Lançamento:** Testes E2E, Segurança e Deploy (CI/CD).

---
**Status:** 🏗️ Em Desenvolvimento (Sprint 1 Ativa)

**Licença:** GPLv3 (GNU General Public License)
