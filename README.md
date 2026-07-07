# local-bike-dbt

### Couche Staging (Bronze)
Nettoyage des 9 tables sources :

| Modèle | Description |
|---|---|
| `stg_local_bike_orders` | Commandes — cast des dates, gestion des NULL |
| `stg_local_bike_order_items` | Lignes de commande — calcul du total_amount |
| `stg_local_bike_customers` | Clients — zip_code en STRING |
| `stg_local_bike_products` | Produits |
| `stg_local_bike_stores` | Magasins — zip_code en STRING |
| `stg_local_bike_staffs` | Vendeurs — active en BOOL |
| `stg_local_bike_brands` | Marques |
| `stg_local_bike_categories` | Catégories |
| `stg_local_bike_stocks` | Stocks — clé composite store_id + product_id |

### Couche Intermediate (Silver)
Enrichissement par jointures :

| Modèle | Description |
|---|---|
| `int_local_bike_orders_enriched` | Commandes + client + magasin + vendeur + délais |
| `int_local_bike_order_items_enriched` | Lignes + produit + marque + catégorie |
| `int_local_bike_order_summary` | Agrégats par commande (CA, items, retards) |
| `int_local_bike_stock_status` | Stock par produit avec classification (rupture/faible/OK) |

### Couche Mart (Gold)
Tables finales pour les dashboards :

| Modèle | Description |
|---|---|
| `mrt_local_bike_sales_by_store` | CA mensuel par magasin |
| `mrt_local_bike_product_performance` | Top produits par CA |
| `mrt_local_bike_customer_overview` | Vue 360° client |
| `mrt_local_bike_staff_performance` | Performance des vendeurs |
| `mrt_local_bike_stock_alerts` | Alertes rupture et stock faible |

---

## Axes d'analyse

### 1. Performance des ventes
**Modèle :** `mrt_local_bike_sales_by_store`

| Question | Champs |
|---|---|
| Quel est le CA par mois ? | `order_month` + `total_revenue` |
| Combien de commandes par mois ? | `order_month` + `total_orders` |
| Quel est le panier moyen ? | `avg_order_value` |
| Quel magasin performe le mieux ? | `store_name` + `total_revenue` |
| Quel taux de commandes en retard ? | `late_order_pct` |

### 2. Analyse produits
**Modèle :** `mrt_local_bike_product_performance`

| Question | Champs |
|---|---|
| Quels sont les 10 produits les plus vendus ? | `product_name` + `total_revenue` |
| Quelle catégorie génère le plus de CA ? | `category_name` + `total_revenue` |
| Quelle marque est la plus populaire ? | `brand_name` + `total_quantity_sold` |
| Quels produits ont les plus fortes remises ? | `product_name` + `avg_discount` |

### 3. Analyse clients
**Modèle :** `mrt_local_bike_customer_overview`

| Question | Champs |
|---|---|
| Quels sont les clients les plus fidèles ? | `lifetime_value` + `total_orders` |
| Quelle est la répartition géographique ? | `state` + `city` |
| Quand a eu lieu la dernière commande ? | `last_order_date` |
| Quel est le panier moyen par client ? | `avg_order_value` |

### 4. Performance des vendeurs
**Modèle :** `mrt_local_bike_staff_performance`

| Question | Champs |
|---|---|
| Quel vendeur génère le plus de CA ? | `staff_id` + `total_revenue_generated` |
| Quel vendeur traite le plus de commandes ? | `total_orders_handled` |
| Quel vendeur expédie le plus vite ? | `avg_days_to_ship` |
| Quel vendeur a le plus de retards ? | `late_orders_count` |

### 5. Gestion des stocks
**Modèle :** `mrt_local_bike_stock_alerts`

| Question | Champs |
|---|---|
| Quels produits sont en rupture ? | `stock_level = out_of_stock` |
| Quels produits ont un stock faible ? | `stock_level = low_stock` |
| Dans quel magasin les stocks sont critiques ? | `store_id` + `stock_level` |

---

## Tests

35 tests implémentés :
- **Tests génériques** : unicité et non-nullité des clés primaires, relations entre tables, valeurs acceptées
- **Tests singuliers** : montants négatifs, remises hors limites

```bash
dbt test
```

---

## Commandes utiles

```bash
# Lancer tous les modèles
dbt run

# Lancer uniquement le staging
dbt run --select staging.local_bike

# Lancer les tests
dbt test

---

## Source des données

- **Host** : Neon PostgreSQL (eu-central-1)
- **Ingestion** : Fivetran → BigQuery dataset `public`
- **9 tables** : orders, order_items, customers, products, stores, staffs, brands, categories, stocks
