`include "tester.v"
`include "Cajero.v"
                                        
// Testbench
module Cajero_tb;
  // Declaración de señales
  wire CLK, RESET;
  wire TARJETA_RECIBIDA, TIPO_TRANS, DIGITO_STB, MONTO_STB;
  wire [3:0] DIGITO;
  wire [15:0] PIN;
  wire [31:0] MONTO;
  wire BALANCE_ACTUALIZADO, ENTREGAR_DINERO, FONDOS_INSUFICIENTES, PIN_INCORRECTO, BLOQUEO;
  wire [1:0] ADVERTENCIA;

  // Instancia de tester
  tester P0 (
    .CLK (CLK), 
    .RESET (RESET), 
    .TARJETA_RECIBIDA (TARJETA_RECIBIDA),
    .TIPO_TRANS (TIPO_TRANS),
    .DIGITO_STB (DIGITO_STB),
    .MONTO_STB (MONTO_STB),
    .DIGITO (DIGITO),
    .PIN (PIN),
    .MONTO (MONTO),
    .BALANCE_ACTUALIZADO (BALANCE_ACTUALIZADO),
    .ENTREGAR_DINERO (ENTREGAR_DINERO),
    .FONDOS_INSUFICIENTES (FONDOS_INSUFICIENTES),
    .PIN_INCORRECTO (PIN_INCORRECTO),
    .BLOQUEO (BLOQUEO)
  );

  // Instancia de la unidad bajo prueba (UUT)
  Cajero uut (
    .CLK (CLK), 
    .RESET (RESET), 
    .TARJETA_RECIBIDA (TARJETA_RECIBIDA),
    .TIPO_TRANS (TIPO_TRANS),
    .DIGITO_STB (DIGITO_STB),
    .MONTO_STB (MONTO_STB),
    .DIGITO (DIGITO),
    .PIN (PIN),
    .MONTO (MONTO),
    .BALANCE_ACTUALIZADO (BALANCE_ACTUALIZADO),
    .ENTREGAR_DINERO (ENTREGAR_DINERO),
    .FONDOS_INSUFICIENTES (FONDOS_INSUFICIENTES),
    .PIN_INCORRECTO (PIN_INCORRECTO),
    .BLOQUEO (BLOQUEO)
  );


  // Dumpfile y monitor
  initial begin
    $dumpfile("resultados.vcd");
    $dumpvars(0, Cajero_tb);
  end

endmodule
