package code;

import java_cup.runtime.Symbol;

parser code
{:
    private Symbol s;
    
    public void syntax_error(Symbol s){
        this.s = s;
    }

    public Symbol getS(){
        return this.s;
}
:};

terminal Linea, Comillas, T_dato, Int, Cadena, If, Else, Do, While, For,
    Igual, Suma, Resta, Multiplicacion, Division, Op_logico, Op_relacional,
    Op_atribucion, Op_incremento, Op_booleano, Parentesis_a, Parentesis_c,
    Llave_a, Llave_c, Corchete_a, Corchete_c, Main, P_coma, Identificador,
    Numero, ERROR;
non terminal INICIO, SENTENCIA, DECLARACION, DECLARACION_FOR, IF, IF_ELSE,
    WHILE, DO_WHILE, FOR, SENTENCIA_BOOLEANA, SENTENCIA_FOR;

start with INICIO;

INICIO ::= 
    Int Main Parentesis_a Parentesis_c Llave_a SENTENCIA Llave_c |
    Main Parentesis_a Parentesis_c Llave_a SENTENCIA Llave_c
;
SENTENCIA ::= 
    SENTENCIA DECLARACION |
    DECLARACION |
    SENTENCIA IF | 
    IF |
    SENTENCIA IF_ELSE |
    IF_ELSE |
    SENTENCIA WHILE |
    WHILE |
    SENTENCIA DO_WHILE
    DO_WHILE |
    SENTENCIA FOR |
    FOR
;
DECLARACION ::= 
    Int Identificador P_coma | 
    Int Identificador Op_atribucion Numero P_coma |
    Int Identificador Igual Numero P_coma |
    Int Identificador Op_incremento P_coma | 
    Int Op_incremento Identificador P_coma | 
    T_dato Identificador P_coma | 
    T_dato Identificador Op_atribucion Numero P_coma |
    T_dato Identificador Igual Numero P_coma |
    T_dato Identificador Op_incremento P_coma | 
    T_dato Op_incremento Identificador P_coma | 
    Cadena Identificador Op_atribucion Comillas Comillas P_coma |
    Cadena Identificador Igual Comillas Comillas P_coma |
    Cadena Identificador Op_atribucion Comillas Identificador Comillas P_coma |
    Cadena Identificador Igual Comillas Identificador Comillas P_coma
;
IF ::= If Parentesis_a SENTENCIA_BOOLEANA Parentesis_c Llave_a SENTENCIA Llave_c
;
SENTENCIA_BOOLEANA ::= 
    Op_booleano | 
    Identificador Op_relacional Op_booleano |
    Identificador Op_relacional Numero |
    Identificador Op_relacional Identificador |
    Identificador Op_relacional Comillas Comillas |
    Identificador Op_relacional Comillas Identificador Comillas
;
IF_ELSE ::= If Parentesis_a SENTENCIA_BOOLEANA Parentesis_c Llave_a SENTENCIA Llave_c Else Llave_a SENTENCIA Llave_c
;
WHILE ::= While Parentesis_a SENTENCIA_BOOLEANA Parentesis_c Llave_a SENTENCIA Llave_c
;
DO_WHILE ::= Do Llave_a SENTENCIA Llave_c While Parentesis_a SENTENCIA_BOOLEANA Parentesis_c P_coma
;
FOR ::= For Parentesis_a SENTENCIA_FOR Parentesis_c Llave_a SENTENCIA Llave_c
;
SENTENCIA_FOR ::=
    T_dato Identificador Igual Numero P_coma SENTENCIA_BOOLEANA P_coma DECLARACION_FOR |
    Identificador Igual Numero P_coma SENTENCIA_BOOLEANA P_coma DECLARACION_FOR
;
DECLARACION_FOR ::= 
    Identificador Op_atribucion Numero |
    Identificador Op_incremento | 
    Op_incremento Identificador
;