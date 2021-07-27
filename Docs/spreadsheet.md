# How to work with Google Spreasheet

## Overview

- [Rules](#Rules)
- [Custom types](#Custom-types)
- [Default types](Default#-types)
- [Events](#Events)
- [Integration](#Integration)

Template you can [find here](https://docs.google.com/spreadsheets/d/1a9UAiDPmVx_5qEv6EIpCzBx-rW64yjxH2Ptpfj6AP3A/edit?usp=sharing)

## Rules

- you can give any name for page (just fill name in config properly)
- `page name`, `event name`, `parameter name` must not contains spaces (you can replace space with _)

## Custom types

For filling custom enumerations there is page (default name is `Types`)

**There are colums:**

- Name - name of custom type
- Description (comment in code will be generated)
- Variant - enumeration variant for current type
- Variant description (comment in code will be generated)

## Default types

Script supports default types:

- integer
- double
- string
- date

## Events

For filling events there is page (default name is `Version_1.0`).

The main feature of this page is that you can create multiple versions of page. After working on new version just say developers to rename parameter in config to newer page version.

**There are colums:**

- Category - category of event (to group similar events). If you don't want to group, just name this column `Base`
- Category description (comment in code will be generated)
- Event name
- Event Description (comment in code will be generated)
- Parameter name
- Parameter type - supports [default types](#Default-types) and [custom types](#Custom-types)
- Parameter description (comment in code will be generated)

## Integration

To fill config you need to know:

- table identifier
- page name - name of your page (for example `Types`)
- data range - range of data (for example `A1:F100`)

To found table identifier just research URL of page - `https://docs.google.com/spreadsheets/d/{spreadsheet_id}/edit#gid=0`.

For example `https://docs.google.com/spreadsheets/d/abc1234567/edit#gid=0` - identifier here is `abc1234567`
