`timescale 1ns / 1ps 
module tester(
    output reg CLK,
    output reg RESET,
    output reg TARJETA_RECIBIDA,
    output reg [15:0] PIN,
    output reg [3:0] DIGITO,
    output reg DIGITO_STB,
    output reg TIPO_TRANS, //0 para deposito, 1 para retiro
    output reg [31:0] MONTO, // creo que va en el tb
    output reg MONTO_STB, //falta
    input BALANCE_ACTUALIZADO,
    input ENTREGAR_DINERO,
    input FONDOS_INSUFICIENTES, 
    input PIN_INCORRECTO,
    input [1:0] ADVERTENCIA,
    input BLOQUEO);



    initial begin
    CLK = 0;
    // Se alterna entre 0 y 1 cada 5 unidades de tiempo
     forever #5 CLK = ~CLK; // Ciclo de reloj de 10 unidades de tiempo
  end
  initial begin
  /////////////////////////////////////////////////////////////////////
  //Prueba 1, funcionamiento ideal, deposito
  RESET = 0; 
  TARJETA_RECIBIDA = 0; 
  PIN = 0;
  DIGITO = 0;
  DIGITO_STB = 0;
  TIPO_TRANS = 0;
  MONTO_STB = 0;
  MONTO = 0;
  #10;
  RESET = 1; 

  RESET = 1;
  TARJETA_RECIBIDA = 1;
  PIN = 16'b0110011101100111;

  MONTO = 32'b00000000000000100100100111110000;//150 mil
  MONTO_STB = 1;
  #10;
  MONTO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
/////////////////////////////////////////////////////////////////
//Prueba 2, funcionamiento ideal, retiro con fondos insuficientes
  RESET = 0; 
  TARJETA_RECIBIDA = 0; 
  PIN = 0;
  DIGITO = 0;
  DIGITO_STB = 0;
  TIPO_TRANS = 0;
  MONTO_STB = 0;
  MONTO = 0;
  #10;
  RESET = 1; 

  RESET = 1;
  TARJETA_RECIBIDA = 1;
  TIPO_TRANS = 1;
  PIN = 16'b0110011101100111;
  MONTO = 32'b00000000000001010101011100110000; //350 mil para retirar
  MONTO_STB = 1;
  #10;
  MONTO_STB = 0;
  #10;

  TARJETA_RECIBIDA = 1;
  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Tercer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
  DIGITO = 4'b0111; //Cuarto digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
/////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////
//Prueba 3, funcionamiento ideal, retiro con fondos suficientes
  RESET = 0; 
  TARJETA_RECIBIDA = 0; 
  PIN = 0;
  DIGITO = 0;
  DIGITO_STB = 0;
  TIPO_TRANS = 0;
  MONTO_STB = 0;
  MONTO = 0;
  #10;
  RESET = 1; 

  RESET = 1;
  TARJETA_RECIBIDA = 1;
  TIPO_TRANS = 1;
  PIN = 16'b0110011101100111;
  MONTO = 32'b00000000000001001001001111100000; //300 mil para retirar
  MONTO_STB = 1;
  #10;
  MONTO_STB = 0;
  #10;

  TARJETA_RECIBIDA = 1;
  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Tercer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
  DIGITO = 4'b0111; //Cuarto digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
/////////////////////////////////////////////////////////////////////
//Prueba 4, funcionamiento no ideal, se levantan alertas y pines incorrectos, bloqueos, deposito.
  RESET = 0; 
  TARJETA_RECIBIDA = 0; 
  PIN = 0;
  DIGITO = 0;
  DIGITO_STB = 0;
  TIPO_TRANS = 0;
  MONTO_STB = 0;
  MONTO = 0;
  #10;
  RESET = 1; 

  RESET = 1;
  TARJETA_RECIBIDA = 1;
  PIN = 16'b0110011101100111;
  MONTO = 32'b00000000000000100100100111110000; //150 mil para depositar
  MONTO_STB = 1;
  #10;
  MONTO_STB = 0;
  #10;

  TARJETA_RECIBIDA = 1;
  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0001; //Tercer digito, este corresponde a 1. Como es incorrecto, se reinician los digitos.
  DIGITO_STB = 1;   //Contador de errores llega a 1.
  #10;              //Se levanta Pin Incorrecto.
  DIGITO_STB = 0;
  #10;
  DIGITO = 0;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Tercer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0001; //Cuarto digito, este corresponde a 1. Es incorrecto, se reinician los digitos.
  DIGITO_STB = 1;   // Contador de errores llega a 2. Se levanta una advertencia.
  #10;              // Se levanta Pin Incorrecto
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6.
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b1001; //Segundo digito, este corresponde a 9.Es incorrecto, se reinician los digitos.
  DIGITO_STB = 1; //Contador de errores llega a 3. Se levanta un Bloqueo.
  #10;            //// Se levanta Pin Incorrecto
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6.
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;   //Como Bloqueo esta activo, hay que reiniciar todo para proceder.
  #10;
  DIGITO_STB = 0;
  #10;

  RESET = 0; //Reset
  DIGITO = 4'b0000;
  MONTO = 32'b00000000000000000000000000000000;
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
  

  RESET = 1;
  TARJETA_RECIBIDA = 1;
  PIN = 16'b0110011101100111;
  MONTO = 32'b00000000000000100100100111110000;//150 mil
  MONTO_STB = 1;
  #10;
  MONTO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
/////////////////////////////////////////////////////////////////////
//Prueba 5, funcionamiento no ideal, se levantan alertas y pines incorrectos, bloqueos, retiro.
RESET = 0; 
  TARJETA_RECIBIDA = 0; 
  PIN = 0;
  DIGITO = 0;
  DIGITO_STB = 0;
  TIPO_TRANS = 1;
  MONTO_STB = 0;
  MONTO = 0;
  #10;
  RESET = 1; 

  RESET = 1;
  TARJETA_RECIBIDA = 1;
  PIN = 16'b0110011101100111;
  MONTO = 32'b00000000000000010010010011111000; //75 mil para retirar
  MONTO_STB = 1;
  #10;
  MONTO_STB = 0;
  #10;

  TARJETA_RECIBIDA = 1;
  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0001; //Tercer digito, este corresponde a 1. Como es incorrecto, se reinician los digitos.
  DIGITO_STB = 1;   //Contador de errores llega a 1.
  #10;              //Se levanta Pin Incorrecto.
  DIGITO_STB = 0;
  #10;
  DIGITO = 0;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Tercer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0001; //Cuarto digito, este corresponde a 1. Es incorrecto, se reinician los digitos.
  DIGITO_STB = 1;   // Contador de errores llega a 2. Se levanta una advertencia.
  #10;              // Se levanta Pin Incorrecto
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6.
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b1001; //Segundo digito, este corresponde a 9.Es incorrecto, se reinician los digitos.
  DIGITO_STB = 1; //Contador de errores llega a 3. Se levanta un Bloqueo.
  #10;            //// Se levanta Pin Incorrecto
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6.
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;   //Como Bloqueo esta activo, hay que reiniciar todo para proceder.
  #10;
  DIGITO_STB = 0;
  #10;

  RESET = 0; //Reset
  DIGITO = 4'b0000;
  MONTO = 32'b00000000000000000000000000000000;
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
  

  RESET = 1;
  TARJETA_RECIBIDA = 1;
  PIN = 16'b0110011101100111;
  MONTO = 32'b00000000000000010010010011111000;//150 mil
  MONTO_STB = 1;
  #10;
  MONTO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;

  DIGITO = 4'b0110; //Primer digito, este corresponde a 6
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
  DIGITO = 4'b0111; //Segundo digito, este corresponde a 7
  DIGITO_STB = 1;
  #10;
  DIGITO_STB = 0;
  #10;
  $finish;
  end
endmodule

