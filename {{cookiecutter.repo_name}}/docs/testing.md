# Ventorystack Testing With Behave

It is recommended that you read the following two tutorials prior:

- [Behave Getting Started docs](http://pythonhosted.org/behave/)
- [Behave Django docs](https://pythonhosted.org/behave-django/)
- [pyhamcrest docs](https://pyhamcrest.readthedocs.io/en/release-1.8/tutorial/)
- [Factory Boy docs](http://factoryboy.readthedocs.io/en/latest/)

## Dependences package Testings.

Firstly, ensure you are using at least the following versions of each package.

- `behave-django==0.3.0`
- `factory-boy==2.7.0`
- `PyHamcrest==1.9.0`

## Factory Boy

Path:

**src/test/factories**:

```bash
├── __init__.py
├── company.py
```

### Example Factory Boy

**Create User**:

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-

import factory
from customuser.models import MyUser
from factory import Sequence
from factory.django import DjangoModelFactory

class UserFactory(DjangoModelFactory):

    class Meta:
        model = MyUser
        django_get_or_create = (
            'email',
            'password',
        )
    email = Sequence(lambda n: 'email #%s' % n)
    password = 'P@ssw0rd'
    first_name = 'veny'
    last_name = 'bodoque'
    mobile = '051959196850'
```

**Code:**

```python
#!/usr/bin/env python
# -*- coding: utf-8 -*-
from test.factories.user import UserFactory

user = UserFactory(email=user_email)
user.set_password('P@ssw0rd')
user.save()
```

## Behave

Path:

**src/features**:
```bash
├── __init__.py
├── environment.py
├── product.feature
```

**src/features/steps**:
```bash
├── __init__.py
└── product.py
```

### Example Behave:

A Feature:

```feature
@product
Feature: Register Producto

  Scenario: User Creates a Product
    Given company "dgnest" with user "veny@dgnest.com"
    When make "product" with:
        | name                     | sku     | brand   | product_type | description                                            | sale_price | initial_stock | initial_location | initial_cost | retail_price | wholesale_price | has_variants |
        | Cartera de mano Andolini | ANDO987 | Crepier | Cartera      | Bonita cartera de mano hecha de los mejores materiales |        150 |            80 |                1 |           90 |           80 |              70 | true         |
    And make "product" with "options":
        | Tallas        | Colores          |
        | ["s","m","l"] | ["rojo","verde"] |
    And make "product" with some "variants":
        | name       | product_type | brand   | description             | sku      | initial_location | initial_stock | initial_cost | retail_price | wholesale_price | has_variants | option           | prices                                                      |
        | small-rojo | Cartera      | Crepier | Esta es la descriptcion | ando-s-r |                1 |            80 |           80 |          150 |             120 | true         | ["small","rojo"] | [{"price_list":1,"price":120},{"price_list":2,"price":150}] |
    And register the "product" in "create-products" with format "json":
    Then status response is "201"
```

Description:

**When make "product" with:**
Agrega el contenido de la tabla a la variable **context.product**

**And make "product" with "options":**
Agrega el contenido de la tabla al indice **context.product['options']** como objeto

**And make "product" with some "variants":**
Agrega el contenido de la tabla al indice **context.product['variants']** como areglo

```python
from behave import *
from nose.tools import assert_equals, assert_not_equals, assert_true

@given(u'company "{company_name}" with user "{user_email}"')
def company_with_user(context, company_name, user_email):
    user = SuperUserFactory(email=user_email)
    user.set_password('P@ssw0rd')
    user.save()
    assert_true(user)
    company = CompanyFactory.create(name=company_name, owner=user)
    assert_true(company)
    context.user = user
    context.company = company
    client = APITenantClient(tenant=company)
    response = client.login(
        username=user.email,
        password='P@ssw0rd'
    )
    assert_true(response)
    context.client = client
```

Execute a tag:

```bash
make behave tag=product
```

Execute multiple tag:

```bash
make behave tag=product,sales
```

Execute all tag:

```bash
make behave tag=all
```
