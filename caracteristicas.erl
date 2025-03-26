-module(caracteristicas).
-export([ 
    uso_clausulas_1/1, uso_clausulas_2/1,   % Clausulas
    uso_if/1, uso_case/1,    % If y Case
    factorial/1, suma_lista/1,    % Iteración con recursión
    procesos/0   % Procesos
]).

% cd OneDrive\Escritorio\TEC_trabajos\Semestre_4\Parcial_1\Metodos_Comput\Sem6_erlang


%%% ============================
%%% 1. Uso de cláusulas en funciones
%%% ============================

uso_clausulas_1(0) -> io:format("El número es cero.~n");
uso_clausulas_1(1) -> io:format("El número es uno.~n");
uso_clausulas_1(N) when N > 1 -> io:format("El número es mayor que uno: ~p~n", [N]);
uso_clausulas_1(_) -> io:format("El número es negativo.~n").

uso_clausulas_2({nombre, maria, 25}) -> io:format("Maria tiene 25 años.~n");
uso_clausulas_2({nombre, Nombre, Edad}) -> io:format("~p tiene ~p años.~n", [Nombre, Edad]);
uso_clausulas_2({_, _, _}) -> io:format("No tiene la etiqeuta nombre.~n").


%%% ============================
%%% 2. Uso de `if`
%%% ============================

uso_if(N) ->
    if
        N < 0 -> io:format("El número es negativo.~n");
        N == 0 -> io:format("El número es cero.~n");
        true -> io:format("El número es positivo.~n")
    end.


%%% ============================
%%% 3. Uso de `case`
%%% ============================

uso_case(X) ->
    case X of
        0 -> io:format("Es cero.~n");
        1 -> io:format("Es uno.~n");
        2 -> io:format("Es dos.~n");
        _ -> io:format("Es otro número: ~p~n", [X])
    end.

%%% ============================
%%% 4. Iteración con recursión
%%% ============================

% Factorial con recursión
factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N - 1).

% Suma de una lista usando recursión
suma_lista([]) -> 0;
suma_lista([H | T]) -> H + suma_lista(T).

%%% ============================
%%% 5. Procesos y envío de mensajes
%%% ============================

procesos() ->
    Pid = spawn(fun proceso/0),
    Pid ! {self(), "Hola, proceso!"},
    receive
        Respuesta -> io:format("Respuesta del proceso: ~p~n", [Respuesta])
    after 3000 ->
        io:format("No hubo respuesta del proceso.~n")
    end.

proceso() ->
    receive
        {Remitente, Mensaje} ->
            io:format("Mensaje recibido: ~p~n", [Mensaje]),
            Remitente ! "Mensaje recibido!",
            proceso()  %Se mantiene activo para recibir más mensajes
    end.
