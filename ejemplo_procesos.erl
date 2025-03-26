-module(ejemplo_procesos).
-export([proceso/0, iniciar/0]).

proceso() ->
    receive
        {de, Remitente, Mensaje} ->  
            io:format("Mensaje recibido: ~p~n", [Mensaje]),
            Remitente ! "Mensaje recibido!",
            proceso()  % Sigue esperando más mensajes
    end.

iniciar() ->
    Pid = spawn(fun proceso/0),  % Crea un proceso y obtiene su PID
    Pid ! {de, self(), "Hola, proceso!"},  % Envía un mensaje con el PID del proceso actual
    receive
        Respuesta -> io:format("Respuesta: ~p~n", [Respuesta])
    after 5000 ->
        io:format("No hubo respuesta del proceso 2.~n")
    end.
