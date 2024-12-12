module Cajero(
    input CLK,
    input RESET,
    input TARJETA_RECIBIDA,
    input [15:0] PIN,
    input [3:0] DIGITO,
    input DIGITO_STB,
    input TIPO_TRANS, //0 para deposito, 1 para retiro
    input [31:0] MONTO, // creo que va en el tb
    input MONTO_STB, //falta
    output reg BALANCE_ACTUALIZADO,
    output reg ENTREGAR_DINERO,
    output reg FONDOS_INSUFICIENTES, 
    output reg PIN_INCORRECTO,
    output reg [1:0] ADVERTENCIA,
    output reg BLOQUEO
);

reg [63:0] BALANCE= 64'b0000000000000000000000000000000000000000000000100100100111110000; //Registro interno para la plata que hay en la cuenta. Para el ejemplo, se usan 150mil colones, que seria 000000000000000100100100100111010000
//en binario y en 64 bits
reg [2:0] INTENTOS; //Registro interno que hay para validar los intentos 
reg [15:0] DIGITO_INTERNO;
reg [15:0] PROX_DIGITO; //Registro interno para almacenar el proximo digito para el siguiente flop
//Mi pin es 6767, en binario eso es 0110 0111 0110 0111
//La tarea debe funcionar para un solo pin? O para varios usuarios?
//Es para ver si se debe reiniciar el monto o no.

// Máquina de estados
always @(posedge CLK or negedge RESET) begin
    if (!RESET) begin
        DIGITO_INTERNO <= 16'b0000000000000000;
    end else begin 
        DIGITO_INTERNO <= PROX_DIGITO;
    end
end

always @(*) begin
    PROX_DIGITO=DIGITO_INTERNO;
    if (!RESET || TARJETA_RECIBIDA == 0 ) begin
        // Si no hay tarjeta en el cajero, se ponen las señales en 0
        INTENTOS <= 0;
        BLOQUEO <= 0;
        ADVERTENCIA <= 0;
        PIN_INCORRECTO <= 0;
        FONDOS_INSUFICIENTES <= 0;
        ENTREGAR_DINERO <= 0;
        BALANCE_ACTUALIZADO <= 0;

        // Aquí puedes agregar otras señales que necesiten reinicio
    end 
    else if (TARJETA_RECIBIDA && INTENTOS <=2 ) begin
        //PIN <= 16'b0110011101100111; //SE FIJA EL PIN EN EL VALOR QUE ES, ESTE ES EL PIN DE ENTRADA!!!!!!!!!!!!!
        case(DIGITO_INTERNO)
        16'b0000000000000000: begin
        if (DIGITO == 4'b0110 && DIGITO_STB == 1) begin //Si digito es 0110 (6), y digito_stb es 1, se fija el siguiente estado
            PROX_DIGITO = 16'b0000000000000110;
            PIN_INCORRECTO = 0;
            end
        else if (DIGITO_STB == 1) begin 
            PROX_DIGITO = 16'b0000000000000000;
            INTENTOS = INTENTOS+ 1;
            PIN_INCORRECTO = 1;
            end
        end
        16'b0000000000000110: begin 
        if (DIGITO == 4'b0111 && DIGITO_STB == 1) begin //Si digito es 0111 (7), y digito_stb es 1, se fija el siguiente estado
            PROX_DIGITO = 16'b0000000001100111;
            PIN_INCORRECTO = 0;
            end 
        else if (DIGITO_STB == 1) begin 
            PROX_DIGITO = 16'b0000000000000000;
            INTENTOS = INTENTOS+1;
            PIN_INCORRECTO = 1;
            end
        end 
        16'b0000000001100111: begin 
            if (DIGITO == 4'b0110 && DIGITO_STB == 1) begin
            PROX_DIGITO = 16'b0000011001110110;
            PIN_INCORRECTO = 0;
            end  
        else if (DIGITO_STB == 1) begin 
            PROX_DIGITO = 16'b0000000000000000;
            INTENTOS = INTENTOS+1;
            PIN_INCORRECTO = 1;
            end
        end

        16'b0000011001110110: begin
            if (DIGITO == 4'b0111 && DIGITO_STB == 1) begin
            PROX_DIGITO = 16'b0110011101100111;
            PIN_INCORRECTO = 0;
            end
            else if (DIGITO_STB == 1) begin 
            PROX_DIGITO = 16'b0000000000000000;
            INTENTOS = INTENTOS+1;
            PIN_INCORRECTO = 1;
            end
        end
        default: begin// Manejo de estado inesperado
        PROX_DIGITO = 16'b0000000000000000; 
        end
        endcase
        DIGITO_INTERNO = PROX_DIGITO;
            // Verificar si el PIN ingresado es correcto
            if (DIGITO_INTERNO == PIN) begin
                PIN_INCORRECTO = 0;
                if (TIPO_TRANS == 0) begin // Logica si se escoge DEPOSITAR
                    BALANCE = MONTO + BALANCE;
                    BALANCE_ACTUALIZADO <= 1;
                end else begin
                    if (MONTO > BALANCE) begin 
                        FONDOS_INSUFICIENTES <= 1;
                    end else begin 
                        BALANCE = BALANCE - MONTO;
                        BALANCE_ACTUALIZADO <= 1;
                        ENTREGAR_DINERO <= 1;
                    end
                end
            end 


    if (INTENTOS > 0 && INTENTOS ==2) begin
        ADVERTENCIA = 1;
    end
    else begin
        ADVERTENCIA = 0;
    end

    if (INTENTOS==3) begin
        BLOQUEO <= 1;
        ADVERTENCIA <= 0;
        PIN_INCORRECTO <= 1;
        FONDOS_INSUFICIENTES <= 0;
        ENTREGAR_DINERO <= 0;
        BALANCE_ACTUALIZADO <= 0;
    end 
    else begin 
        BLOQUEO=0;
    end
end
end

endmodule