clear all
version 17

*======================================================================
* 01_EAM.do
* Construccion del panel de firmas manufactureras (EAM 2012-2023) y
* estimacion del efecto del Nuevo Puente Pumarejo sobre costos de
* transporte.
*
* UNICO AJUSTE NECESARIO: la ruta del global root.
*
* Fuente: Departamento Administrativo Nacional de Estadistica:
* www.dane.gov.co
*======================================================================

global root "C:/ruta/al/repositorio"
cd "$root"

cap mkdir "Data"
cap mkdir "Temp"
cap mkdir "Output"


*****************************************************************************************************************
************************************Creación Variables***********************************************************
*****************************************************************************************************************
***************** EAM 2012 
use "Data/EAM_2012.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
ren id nordemp
gen TransMP = c3r42c3
gen TransProd = c3r45c3
keep dpto ciiu4 nordemp periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, nordemp, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0 | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia nordemp y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia nordemp y nordest
gsort nordemp -Prod
ren periodo año
ren nordemp id
collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM12.dta", replace
clear
******************* EAM 2013
use "Data/EAM_2013.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
ren ciiu_4 ciiu4
gen TransMP = c3r42c3
gen TransProd = c3r45c3
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0 | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año
collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM13.dta", replace
clear
******************* EAM 2014
use "Data/EAM_2014.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
gen TransMP = c3r42c3
gen TransProd = c3r45c3
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0  | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año
collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM14.dta", replace
clear
******************* EAM 2015
use "Data/EAM_2015.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
gen TransMP = c3r42c3
gen TransProd = c3r45c3
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0  | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año
collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM15.dta", replace
clear
******************* EAM 2016
use "Data/EAM_2016.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
gen TransMP = c3r42c3
gen TransProd = c3r45c3
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0 | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año
collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM16.dta", replace
clear
******************* EAM 2017
use "Data/EAM_2017.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
gen TransMP = c3r42c3
gen TransProd = c3r45c3
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0  | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año

collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM17.dta", replace
clear
******************* EAM 2018
use "Data/EAM_2018.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
gen TransMP = c3r42c3
gen TransProd = c3r45c3
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0 | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
// Ver duplicados
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año

collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM18.dta", replace
clear
******************* EAM 2019
use "Data/EAM_2019.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
gen TransMP = c3r42c3
gen TransProd = c3r45c3
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0  | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año

collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM19.dta", replace
clear
******************* EAM 2020
use "Data/EAM_2020.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
gen TransMP = c3r42c3
gen TransProd = c3r45c3
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0 | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año

collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM20.dta", replace
clear
******************* EAM 2021
use "Data/EAM_2021.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
gen TransMP = c3r42c3
gen TransProd = c3r45c3
ren nordemp id
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0  | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año
collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM21.dta", replace
clear
******************* EAM 2022
use "Data/EAM_2022.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
gen TransMP = c3r42c3
gen TransProd = c3r45c3
ren nordemp id
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0  | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año
collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM22.dta", replace
clear
******************* EAM 2023
use "Data/EAM_2023.dta"
rename *, lower
gen LFem = c4r4c9t
gen LHom = c4r4c10t
gen Labor = LFem + LHom
gen Agua = c3r21c3
gen Pub = c3r22c3
label variable Pub "Gastos en Propaganda y Publicidad"
gen Ener = eelec
label variable Ener "Energía Consumida en KwH"
gen VAgr = valagri
gen IBruta = invebrta
gen AcFij = activfi
gen Depre = deprecia
gen Mat = consin2
gen Prod = prodbr2
gen Wage = salpeyte
gen Exp = porcvt
gen Imp = valorcx
gen ValLibrosIn = c7r10c1
gen ValLibrosFin = c7r10c6
gen Ventas = valorven
gen VentasExt = porcvt 
gen InvInicio = c6r5c1
gen InvFinal = c6r5c3
gen TransMP = c3r42c3
gen TransProd = c3r45c3
ren nordemp id
keep dpto ciiu4 id nordest periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd
drop if missing(dpto, ciiu4, id, periodo, LFem, LHom, Labor, Agua, Pub, Ener, VAgr, IBruta, AcFij, Depre, Mat, Prod, Wage, Exp, Imp, ValLibrosFin, ValLibrosIn, Ventas, VentasExt, InvFinal, InvInicio, TransMP, TransProd)
drop if Labor < 0 | Agua < 0 | Pub < 0 | Ener < 0 | VAgr < 0  | AcFij < 0 | Depre < 0 | Mat < 0 | Prod < 0 | Wage < 0 | Exp < 0 | Imp < 0 | ValLibrosFin < 0 | ValLibrosIn < 0 | Ventas < 0 | VentasExt < 0 | InvFinal < 0 | TransMP < 0 | TransProd < 0 | InvInicio < 0 
duplicates r
duplicates drop
duplicates r dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd // Solo cambia id y nordest
duplicates drop dpto ciiu4 periodo LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, force // Solo cambia id y nordest
gsort id -Prod
ren periodo año
collapse (first) dpto ciiu4 año (sum) LFem LHom Labor Agua Pub Ener VAgr IBruta AcFij Depre Mat Prod Wage Exp Imp ValLibrosFin ValLibrosIn Ventas VentasExt InvFinal InvInicio TransMP TransProd, by(id)
save "Temp/EAM23.dta", replace
clear
*****************************************************************************************************************
******************************************Append*****************************************************************
*****************************************************************************************************************
use "Temp/EAM12.dta"
append using "Temp/EAM13.dta"
append using "Temp/EAM14.dta"
append using "Temp/EAM15.dta"
append using "Temp/EAM16.dta"
append using "Temp/EAM17.dta"
append using "Temp/EAM18.dta"
append using "Temp/EAM19.dta"
append using "Temp/EAM20.dta"
append using "Temp/EAM21.dta"
append using "Temp/EAM22.dta"
append using "Temp/EAM23.dta"
save "Temp/EAMCompleta1.dta", replace
clear
*****************************************************************************************************************
******************************************CIIU/Inflacion*********************************************************
*****************************************************************************************************************
use "Temp/EAMCompleta1.dta"

bys id: gen Nfirms = 1 if [_n] == 1

replace ciiu4 = int(ciiu4/100) if ciiu4 >1000 
replace ciiu4 = int(ciiu4/10) if ciiu4 > 100
tab ciiu4
gen DumCiu = (ciiu4 == 58 | ciiu4 == 59| ciiu4 == 73)
bys id: egen Totciu = sum(DumCiu)
sort id año
*br if Totciu == 1
replace ciiu4 = 18 if ciiu4 == 58
drop if ciiu4 == 73 | ciiu4 == 59

bys id: gen n = _n
ren n Age

gen IPP =.
replace IPP = 92.27 if año == 2012 
replace IPP = 92.16 if año == 2013 
replace IPP = 93.91 if año == 2014 
replace IPP = 100.00 if año == 2015
replace IPP = 105.85 if año == 2016 
replace IPP = 106.64 if año == 2017 
replace IPP = 108.64 if año == 2018 
replace IPP = 112.92 if año == 2019 
replace IPP = 116.15 if año == 2020 
replace IPP = 125.33 if año == 2021 
replace IPP = 146.21 if año == 2022 
replace IPP = 156.18 if año == 2023 
replace IPP = IPP/100

gen Trans = TransMP + TransProd

replace Prod = Prod/IPP
replace Mat = Mat/IPP
replace Agua = Agua/IPP
replace Pub = Pub/IPP
replace Ener = Ener/IPP
replace VAgr = VAgr/IPP
replace IBruta = IBruta/IPP
replace Depre = Depre/IPP
replace AcFij = AcFij/IPP
replace Wage = Wage/IPP
replace Exp = Exp/IPP
replace Imp = Imp/IPP
replace ValLibrosFin = ValLibrosFin/IPP
replace ValLibrosIn = ValLibrosIn/IPP
replace Ventas = Ventas/IPP
replace VentasExt = VentasExt/IPP
replace InvFinal = InvFinal/IPP
replace InvInicio = InvInicio/IPP
replace Trans = Trans/IPP
replace TransMP = TransMP/IPP
replace TransProd = TransProd/IPP

gen fbk = .
replace fbk = 160351 if año == 2012
replace fbk = 172869 if año == 2013
replace fbk = 193533 if año == 2014
replace fbk = 191305 if año == 2015
replace fbk = 190994 if año == 2016
replace fbk = 184828 if año == 2017
replace fbk = 187608 if año == 2018
replace fbk = 193147 if año == 2019
replace fbk = 153203 if año == 2020
replace fbk = 170923 if año == 2021
replace fbk = 198344 if año == 2022
replace fbk = 166571 if año == 2023
replace fbk = fbk / 191305

gen TasDep = .
replace TasDep = .0379224  if año == 2012
replace TasDep = .0382756 if año == 2013
replace TasDep = .0387253 if año == 2014
replace TasDep = .0392511 if año == 2015
replace TasDep = .0393168 if año == 2016
replace TasDep = .0390836 if año == 2017
replace TasDep = .0389808 if año == 2018
replace TasDep = .0391716 if año == 2019
replace TasDep = .0393498 if año == 2020
replace TasDep = .0395242 if año == 2021
replace TasDep = .0396775 if año == 2022
replace TasDep = .0398105 if año == 2023

gen Kap =(AcFij-Depre)/fbk if [_n] ==1
replace Kap = (1-TasDep)*Kap[_n-1]+(IBruta[_n-1]) if [_n] >1

// Capital con la tasa de depreciación del profe
gen Kap1 =(AcFij-Depre)/fbk if [_n] ==1
replace Kap1 = (1-0.0686)*Kap[_n-1]+(IBruta[_n-1]) if [_n] >1

drop if Kap < 0
drop if Kap1 < 0

xtset id año

replace Pub = 0.01 if Pub == 0
replace Ener = 0.01 if Ener == 0
replace Labor = 0.01 if Labor == 0
replace Agua = 0.01 if Agua == 0
replace Kap = 0.01 if Kap == 0
replace Kap1 = 0.01 if Kap1 == 0
replace Prod = 0.01 if Prod == 0
replace Mat = 0.01 if Mat == 0
replace LHom = 0.01 if LHom == 0
replace LFem = 0.01 if LFem == 0
replace Wage = 0.01 if Wage == 0
replace Exp = (Exp != 0)
gen MatImp = Imp
replace Imp = (Imp != 0)

	
gen LProd = log(Prod)
gen LMat = log(Mat)
gen LPub = log(Pub)
gen LAgua = log(Agua)
gen LEner = log(Ener)
gen LLabor = log(Labor)
gen LKap = log(Kap)
gen LKap1 = log(Kap1)

gen allvars=(LProd!=. & LLabor!=. & LMat!=. & LKap1!=.)  
tab ciiu4 if allvars==1
gen mat_over_sales=LMat/LProd
gen va_nom=LProd-LMat
gen tfp_sample01=(mat_over_sales<=1)
tab tfp_sample01
gen tfp_sample02=(va_nom>0 & va_nom!=.)
tab tfp_sample02
gen ratkout=LKap1/LProd
gen ratktrab=LKap1/LLabor
centile ratkout, c(1 99) 
	scalar ratkout1=r(c_1)
	scalar ratkout99=r(c_2)
gen tfp_sample1=(ratkout>ratkout1 & ratkout<ratkout99) 
centile ratktrab, c(1 99)
	scalar ratktrab1=r(c_1)
	scalar ratktrab99=r(c_2)
gen tfp_sample2=(ratktrab>ratktrab1 & ratkout<ratktrab99) 
tab tfp_sample1 tfp_sample2
gen tfp_sample=(tfp_sample1==1 & tfp_sample2==1 & tfp_sample01==1 & tfp_sample02==1)
bys id: gen num_sample=_N
tab num_sample
ren num_sample EdadTot
label variable EdadTot "Número de años que aparece la empresa en la EAM"
sort id año

gen Micro = (Labor < 10)
gen Peque = (Labor > 10 & Labor <= 50)
gen Media = (Labor > 50 & Labor <= 200)
gen Gran = (Labor > 200)
gen PyMes = (Peque == 1 | Media == 1)

prodest LProd if tfp_sample == 1, free(LLabor LAgua) proxy(LMat LEner) state(LKap) method(wrdg) poly(3) gmm
predict ltfp, residuals
estimates store reg1

esttab reg1, cells(b(star fmt(%9.3f)) se(par)) starl(* 0.10 ** 0.05 *** 0.010) legend label stats(N N_g, labels ("No. of Obs." "No. of Firms") fmt(%9.0f %9.0f))
esttab reg1 using "Output/tab_produccion.rtf", replace cells(b(star fmt(%9.3f)) se(par)) starl(* 0.10 ** 0.05 *** 0.010) legend label stats(N N_g, labels ("No. of Obs." "No. of Firms") fmt(%9.0f %9.0f))


table año, stat(mean ltfp)
table ciiu4, stat(mean ltfp)
bys año: egen tfpmean = mean(ltfp)
tsline tfpmean
save "Temp/EAM12-23.dta", replace

******************** Dif & Dif 2013-2023 PANEL 
drop if año < 2013
xtset id año
drop if tfp_sample == 0

label define ciiu4 10 "Food (10)" 11 "Beverages (11)" 13 "Textiles (13)" 14 "Garment (14)" 15 "Leather (15)" 16 "Wood (16)" 17 "Paper (17)" 18 "Publishing (18)" 19 "Coking (19)" 20 "Chemical (20)" 21 "Pharmaceutical (21)" 22 "Rubber and Plastic (22)" 23 "Non-Metallic Mineral Products (23)" 24 "Metallurgical Products (24)" 25 "Metal products (25)" 26 "Manufacture of Electronics (26)" 27 "Electric motors (27)" 28 "Machinery and Equipment (28)" 29 "Vehicles (29)" 30 "Ships and Boats (30)" 31 "Furniture (31)" 32 "Others (32)" 33 "Machine Maintenance (33)" 
label values ciiu4 ciiu4

gen KL = log(Kap/Labor)

replace Ventas = 0.01 if Ventas == 0
gen LVen = log(Ventas)

replace VAgr = 0.01 if VAgr == 0
gen LVa = log(VAgr)

gen lw = log(Wage)
gen Wagpc = log(Wage/Labor)

gen LowT = 0
replace LowT = 1 if ciiu4 <= 18 | ciiu4 == 31
gen MedT = 0
replace MedT = 1 if ciiu4 >= 19 & ciiu4 <= 25
gen HighT = 0
replace HighT = 1 if ciiu4 >=26 & ciiu4 != 31

bys ciiu4 año: egen SectProd = sum(Prod)
gen MShare = Prod/SectProd
gen MShare2 = MShare^2
bys ciiu4 año: egen ihh = sum(MShare2)
replace ihh = log(ihh)
gen LMs = log(MShare)


foreach num of numlist 2012/2023 {
di `num'
gen año_`num' = (año == `num')
}

foreach num of numlist 10 11 13/33 {
di `num'
gen ciiu_`num' = (ciiu4 == `num')
}

gen RevShare=Mat/Prod

bys id: gen markup1_10=0.8214313/RevShare if ciiu4==10
bys id: gen markup1_11=0.9513386/RevShare if ciiu4==11
bys id: gen markup1_13=0.5670008/RevShare if ciiu4==13
bys id: gen markup1_14=0.6501077/RevShare if ciiu4==14
bys id: gen markup1_15=0.6968813/RevShare if ciiu4==15
bys id: gen markup1_16=0.7700267/RevShare if ciiu4==16
bys id: gen markup1_17=0.8181752/RevShare if ciiu4==17
bys id: gen markup1_18=0.6099467/RevShare if ciiu4==18
bys id: gen markup1_19=0.9217589/RevShare if ciiu4==19
bys id: gen markup1_20=0.6177899/RevShare if ciiu4==20
bys id: gen markup1_21=0.9033748/RevShare if ciiu4==21
bys id: gen markup1_22=0.798927/RevShare if ciiu4==22
bys id: gen markup1_23=0.8696062/RevShare if ciiu4==23
bys id: gen markup1_24=0.8878076/RevShare if ciiu4==24
bys id: gen markup1_25=0.7540006/RevShare if ciiu4==25
bys id: gen markup1_26=0.7189916/RevShare if ciiu4==26
bys id: gen markup1_27=0.6668241/RevShare if ciiu4==27
bys id: gen markup1_28=0.6362147/RevShare if ciiu4==28
bys id: gen markup1_29=0.9614078/RevShare if ciiu4==29
bys id: gen markup1_30=0.6192992/RevShare if ciiu4==30
bys id: gen markup1_31=0.7507297/RevShare if ciiu4==31
bys id: gen markup1_32=0.5374741/RevShare if ciiu4==32
bys id: gen markup1_33=0.74117/RevShare if ciiu4==33

egen markup1=rowtotal(markup1_*)
sum markup1
gen lmarkup1=log(markup1)
ren lmarkup1 lMkup
drop markup1_*

gen ExpInd = VentasExt/Ventas
drop if ExpInd > 1

gen ImpInd = MatImp/Mat	
drop if ImpInd > 1	

gen TP = Trans/Prod
drop if TP == 0
gen ltp = log(TP)

drop if TP > 1

gen D = 0
replace D = 1 if dpto == 47 | dpto == 8 | dpto == 13 | dpto == 44  // Guajira no tiene empresas solo (Atlantico, Bolivar, Magdalena, La Guajira)

gen Post = (año >= 2020)

gen did = D * Post

save "Output/Data.dta", replace

xtreg ltp did, fe r
estimates store reg1
reghdfe ltp did, absorb(id año dpto) vce(r)
estimates store reg2

global lx LProd LKap LMat LLabor LAgua LEner 
global y Media Gran // Se trabaja con las pymes como comparación
global z Exp Imp 
global z1 ExpInd ImpInd
global w Wagpc KL lMkup
global v HighT MedT 

reghdfe ltp did ltfp LMs $y $z $w $v, absorb(id) vce(r)
estimates store reg3

reghdfe ltp did ltfp LMs $y $z $w $v, absorb(id año dpto) vce(r)
estimates store reg4

esttab reg3 reg4, cells(b(star fmt(%9.3f)) se(par)) starl(* 0.1 ** 0.05 *** 0.010) legend label stats(N r2 r2_a , labels ("No. of Obs." "R2" "R2 Ajustado: ") fmt(%9.0f %9.3f %9.3f)) // Mostrar en Stata la tabla

esttab reg1 reg2 reg3 reg4, cells(b(star fmt(%9.3f)) se(par)) starl(* 0.105 ** 0.05 *** 0.010) legend label stats(N r2 r2_a n, labels ("No. of Obs." "R2" "R2 Ajustado: ") fmt(%9.0f %9.3f %9.3f)) // Mostrar en Stata la tabla

** Event Study
gen añoD = año * D
reghdfe ltp i.añoD, absorb(id año dpto) vce(r)
estimates store reg1
esttab reg1, cells(b(star fmt(%9.3f)) se(par)) starl(* 0.1 ** 0.05 *** 0.010) legend label stats(N r2 r2_a , labels ("No. of Obs." "R2" "R2 Ajustado: ") fmt(%9.0f %9.3f %9.3f)) // Mostrar en Stata la tabla
esttab reg1 using "Output/tab_principal.rtf", replace cells(b(star fmt(%9.3f)) se(par)) starl(* 0.1 ** 0.05 *** 0.010) legend label stats(N r2 r2_a , labels ("No. of Obs." "R2" "R2 Ajustado: ") fmt(%9.0f %9.3f %9.3f)) // Mostrar en Stata la tabla

** Parallel trends
preserve

* Collapse to year-group means of the transportation cost intensity ratio
collapse (mean) TP, by(D año)

reshape wide TP, i(año) j(D)
rename TP0 Control
rename TP1 Treatment

gen Gap = Treatment - Control

* Approximate y-range for annotation placement (adjust if needed after viewing)
summarize Treatment Control
local ymax = r(max) * 1.08

* PANEL A: Levels, with reference lines and event labels
twoway ///
    (line Control año, lcolor(gs8) lwidth(medthick) lpattern(solid)) ///
    (line Treatment año, lcolor(navy) lwidth(medthick) lpattern(solid)), ///
    xline(2018, lpattern(dash) lcolor(gs10) lwidth(thin)) ///
    xline(2019.96, lpattern(dash) lcolor(black) lwidth(thin)) ///
    text(`ymax' 2017.6 "Malambo-Galapa" "(Dec 2018)", size(vsmall) color(gs6) place(w)) ///
    text(`ymax' 2020.4 "Pumarejo Bridge" "(Dec 2019)", size(vsmall) color(black) place(e)) ///
    legend(order(1 "Control" 2 "Treatment") position(6) rows(1)) ///
    ytitle("Transportation cost / Production ratio") ///
    xtitle("") ///
    xlabel(2013(1)2023, angle(45)) ///
    title("Panel A: Transportation cost intensity by group", size(medium)) ///
    name(panelA, replace)

* PANEL B: Treatment-Control gap over time
twoway ///
    (line Gap año, lcolor(maroon) lwidth(medthick)), ///
    yline(0, lcolor(black) lwidth(thin)) ///
    xline(2018, lpattern(dash) lcolor(gs10) lwidth(thin)) ///
    xline(2019.96, lpattern(dash) lcolor(black) lwidth(thin)) ///
    ytitle("Treatment - Control gap") ///
    xtitle("Year") ///
    xlabel(2013(1)2023, angle(45)) ///
    title("Panel B: Treatment-control gap over time", size(medium)) ///
    legend(off) ///
    name(panelB, replace)

graph combine panelA panelB, cols(1) ysize(8) xsize(6) 
restore

** Balance Table
preserve
keep if año == 2019

eststo clear
estpost ttest ltp ltfp LMs Wagpc KL lMkup HighT MedT Exp Imp Media Gran ExpInd ImpInd, by(D)

esttab using "Output/tab_balance.rtf", replace ///
    cells("mu_1(fmt(%9.3f) label(Treated)) mu_2(fmt(%9.3f) label(Control)) b(star fmt(%9.3f) label(Diff.)) se(par fmt(%9.3f))") ///
    star(* 0.10 ** 0.05 *** 0.01) label noobs ///
    title("Balance table: Treated vs. Control firms (2019, pre-treatment)") ///
    addnotes("Treated firms are located in Atlántico, Bolívar, and Magdalena. Diff. = Treated - Control. *** p<0.01, ** p<0.05, * p<0.10")

* Also display in Stata results window
esttab, cells("mu_1(fmt(%9.3f) label(Treated)) mu_2(fmt(%9.3f) label(Control)) b(star fmt(%9.3f) label(Diff.)) se(par fmt(%9.3f))") ///
    star(* 0.10 ** 0.05 *** 0.01)

* Report N per group for transparency
di "Treated firms (N, 2019):"
count if D == 1
di "Control firms (N, 2019):"
count if D == 0

restore

** PSM - DiD
clear
** A.1: Crear pesos de entropy balancing usando datos pre-tratamiento (2019)
use "Output/Data.dta"

preserve
    keep if año == 2019
    
    * Verificar balance PRE-matching (reproducir Tabla 2)
    ttest ltfp, by(D)
    ttest LMs, by(D)
    ttest Wagpc, by(D)
    ttest KL, by(D)
    ttest lMkup, by(D)
    ttest HighT, by(D)
    ttest MedT, by(D)
    ttest Media, by(D)
    ttest Gran, by(D)
    ttest ExpInd, by(D)
    ttest ImpInd, by(D)
    
    * Entropy Balancing: bal en medias (targets=1), varianzas (targets=2)
    * Las firmas tratadas reciben peso 1; los pesos se asignan a controles
    ebalance D ltfp LMs Wagpc KL lMkup HighT MedT Media Gran ExpInd ImpInd, targets(1) // balance en medias; cambiar a targets(2) para incluir varianzas
    
    * _webal contiene los pesos para las firmas de control
    * Verificar balance POST-entropy balancing
    * (Las medias deben ser casi idénticas entre tratados y controles ponderados)
    replace _webal = 1 if D == 1
    * Guardar pesos por firma
    gen eb_weight = _webal
    keep id eb_weight
    
	count if eb_w == .
    save "Temp/Weights19.dta", replace
restore

merge m:1 id using "Temp/Weights19.dta", keep(1 3) nogen

replace eb_w = 1 if D == 1 & eb_w == .

** (aw = analytic weights, apropiado para pesos de importancia tipo EB)

* Col 1: solo FE de firma (sin controles)
reghdfe ltp did [aw=eb_w], absorb(id) vce(r)
estimates store reg_eb1

* Col 2: FE de firma + año + departamento (sin controles)
reghdfe ltp did [aw=eb_w], absorb(id año dpto) vce(r)
estimates store reg_eb2

* Col 3: FE de firma + controles (sin FE de tiempo)
reghdfe ltp did ltfp LMs $y $z $w $v [aw=eb_w], absorb(id) vce(r)
estimates store reg_eb3

* Col 4: especificación preferida - FE dobles + controles
reghdfe ltp did ltfp LMs $y $z $w $v [aw=eb_w], absorb(id año dpto) vce(r)
estimates store reg_eb4

** Tabla comparativa (misma estructura que Tabla 3 del paper)
esttab reg_eb1 reg_eb2 reg_eb3 reg_eb4 using "Output/tab_entropy_balancing.rtf", ///
    cells(b(star fmt(%9.3f)) se(par)) ///
    starl(* 0.10 ** 0.05 *** 0.01) ///
    legend label ///
    stats(N r2 r2_a, labels("No. of Obs." "R2" "R2 Adj.") ///
          fmt(%9.0f %9.3f %9.3f))
		  
** Comparativa Did - EBalance + Did

global lx LProd LKap LMat LLabor LAgua LEner 
global y Media Gran // Se trabaja con las pymes como comparación
global z Exp Imp 
global z1 ExpInd ImpInd
global w Wagpc KL lMkup
global v HighT MedT 

reghdfe ltp did ltfp LMs $y $z $w $v, absorb(id) vce(r)
estimates store reg3

reghdfe ltp did ltfp LMs $y $z $w $v, absorb(id año dpto) vce(r)
estimates store reg4

esttab reg4 reg_eb4, ///
    cells(b(star fmt(%9.3f)) se(par)) ///
    starl(* 0.10 ** 0.05 *** 0.01) ///
    legend label ///
    stats(N r2 r2_a, labels("No. of Obs." "R2" "R2 Adj.") ///
          fmt(%9.0f %9.3f %9.3f))
		  
** TABLA DE BALANCE POST-EB (para reportar en el paper)
** Muestra que las diferencias de medias desaparecen tras los pesos
preserve
    keep if año == 2019
    ebalance D ltfp LMs Wagpc KL lMkup HighT MedT Media Gran ExpInd ImpInd, ///
        targets(1)
    replace _webal = 1 if D == 1
    
* Post-EB Balance Table (workaround para ttest sin weights)
eststo clear

local vars ltfp LMs Wagpc KL lMkup HighT MedT Media Gran ExpInd ImpInd

foreach var of local vars {
    quietly {
        * Media ponderada: Tratados (D=1)
        sum `var' [aw=_webal] if D == 1
        local m1 = r(mean)

        * Media ponderada: Control (D=0)
        sum `var' [aw=_webal] if D == 0
        local m0 = r(mean)

        * Diferencia + SE + p-valor via regresión ponderada
        reg `var' D [pw=_webal], vce(robust)
        eststo `var'

        * Agregar las medias como escalares al modelo almacenado
        estadd scalar mu_1 = `m1'
        estadd scalar mu_2 = `m0'
    }
}

esttab, cells(mu_1(fmt(%9.3f) label(Treated)) mu_2(fmt(%9.3f) label(Control_EB)) b(star fmt(%9.3f) label(Diff.)) se(par fmt(%9.3f))) star(* 0.10 ** 0.05 *** 0.01) label noobs
restore

** Robustness Check - Malambo/Cartagena

//Exclude firms in Atlántico and Bolívar (affected by the concurrent 4G corridor: Circunvalar de la Prosperidad / Cartagena-Barranquilla)
drop if dpto == 8 | dpto == 13

//Redefine treatment: only Magdalena firms are treated; control group is unchanged (rest of the country, excluding Atlántico and Bolívar)
gen D_mag = (dpto == 47)
gen did_mag = D_mag * Post

//Baseline DiD, Magdalena-only treatment
xtreg ltp did_mag, fe r
estimates store reg_mag1
reghdfe ltp did_mag, absorb(id año dpto) vce(r)
estimates store reg_mag2

//Full specification with controls (mirrors reg3/reg4 in the main do-file)
reghdfe ltp did_mag ltfp LMs $y $z $w $v, absorb(id) vce(r)
estimates store reg_mag3
reghdfe ltp did_mag ltfp LMs $y $z $w $v, absorb(id año dpto) vce(r)
estimates store reg_mag4

esttab reg_mag1 reg_mag2 reg_mag3 reg_mag4, cells(b(star fmt(%9.3f)) se(par)) starl(* 0.1 ** 0.05 *** 0.010) legend label stats(N r2 r2_a, labels ("No. of Obs." "R2" "R2 Ajustado: ") fmt(%9.0f %9.3f %9.3f)) 

esttab reg_mag1 reg_mag2 reg_mag3 reg_mag4 using "Output/tab_robustez_magdalena.rtf", replace cells(b(star fmt(%9.3f)) se(par)) starl(* 0.1 ** 0.05 *** 0.010) legend label stats(N r2 r2_a, labels ("No. of Obs." "R2" "R2 Ajustado: ") fmt(%9.0f %9.3f %9.3f)) 
