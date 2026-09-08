# Transport Costs and the New Pumarejo Bridge

Replication code for "Impact of the Pumarejo Bridge on transport costs in the manufacturing industry of the Colombian Caribbean", with Vidal-Pinilla, G. J. Accepted at *Estudios de Economía* (June 2026).

## Design

Difference-in-differences on a panel of manufacturing establishments, 2012-2023.

- **Outcome:** log of the ratio of transport expenditure to gross output at the establishment level.
- **Treatment group:** establishments in Atlántico, Bolívar, Magdalena and La Guajira.
- **Post period:** from 2020, the year the bridge opened.
- **Specifications:** establishment fixed effects, and establishment, year and department fixed effects, with robust standard errors.
- **Robustness:** entropy balancing on productivity, market share, wages, capital intensity, markups, technological intensity, firm size and trade orientation; plus a re-estimation restricting treatment to Magdalena.

## Data

**Annual Manufacturing Survey (EAM), 2012-2023.** Microdata from DANE, Colombia's national statistics office. Not included in this repository. [DANE catalog](https://microdatos.dane.gov.co/index.php/catalog/871).

Place the annual files in `Data/` named `EAM_2012.dta` through
`EAM_2023.dta`.

Source: Departamento Administrativo Nacional de Estadística:
www.dane.gov.co

### Note on data access

Establishment-level EAM microdata are restricted. The constructed panel (`Output/Data.dta`) is not published here. To replicate, obtain the source files from DANE and run the first script.

## Repository structure

- `Code/01_EAM.do` — builds the 2012-2023 establishment panel and the analysis variables; produces `Output/Data.dta` and generates the difference-in-differences estimates, balance and robustness checks; produces the tables in `Output/`.
- `Data/` — input microdata (not versioned)
- `Temp/` — annual intermediate files (not versioned; created automatically)
- `Output/` — constructed panel and result tables

## How to run

1. Place the EAM microdata in `Data/` under the names listed above.
2. Open `Code/01_EAM.do`, set the path in `global root`, and run. This produces `Output/Data.dta` and the tables in `Output/`.

## Requirements

- Stata 17 or later
- Packages: `reghdfe`, `estout`, `ebalance`, `prodest`.

## Citation

Ordoñez-Claros, J. M., & Vidal-Pinilla, G. J. (2026). Impact of the Pumarejo Bridge on transport costs in the manufacturing industry of the Colombian Caribbean. *Estudios de Economía*, forthcoming.

## License

Code is released under the MIT License (see `LICENSE`). The article in `Paper/` is licensed separately under CC BY-NC-SA 4.0 by *Estudios de Economía*.

## Author

Jose Manuel Ordoñez Claros —
[ORCID 0009-0000-3332-1087](https://orcid.org/0009-0000-3332-1087)