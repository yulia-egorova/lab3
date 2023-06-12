﻿implement main
    open core, file, stdio

domains
    country = япония; китай; украина; бельгия; белоруссия; индия; мексика; франция; австрия; германия.

class facts - worldDb
    государство : (integer Номер_гос, country Название_гос, string Часть_света, integer Население).
    столица : (integer Номер_столицы, string Название_столицы, integer Население).
    достопримечательности : (integer Номер, string Название_достопримечательности, string Название_столицы).
    представляет : (integer Номер_гос, integer Номер_стол).
    расположение : (string Название_столицы, string Часть_света).

class facts
    s : (integer Sum) single.

clauses
    s(0).

class predicates
    столица_по_части_света : (string Часть_света) failure.
    вывод_населения_гос : (country Название_гос) failure.
    столица_страны : (country Название_гос) failure.
    достопримечательность_столицы : (string Название_столицы) failure.
    где_достопримечательность : (string Название_достопримечательности) failure.
    население_столиц_в_зад_части_света : (string Часть_света) determ.
    список_столиц : () -> string* Столицы.
    список_населения_государств : () -> integer* Население.
    поиск_государства : (country Название_гос) -> boolean Поиск nondeterm.

clauses
    столица_по_части_света(Часть_света) :-
        расположение(Название_столицы, Часть_света),
        write("Вывод столицы по части света: ", Название_столицы),
        nl,
        fail.

    вывод_населения_гос(Название_гос) :-
        государство(_, Название_гос, _, Население),
        write("Вывод населения по названию государства: ", Население),
        nl,
        fail.

    столица_страны(Название_гос) :-
        представляет(Номер_гос, Номер_столицы),
        столица(Номер_столицы, Название_столицы, _),
        государство(Номер_гос, Название_гос, _, _),
        write("Вывод столицы страны по названию государства: ", Название_столицы),
        nl,
        fail.

    достопримечательность_столицы(Название_столицы) :-
        достопримечательности(_, Название_достопримечательности, Название_столицы),
        write("Вывод достопримечательности столицы по её названию: ", Название_достопримечательности),
        nl,
        fail.

    где_достопримечательность(Название_достопримечательности) :-
        расположение(Название_столицы, Часть_света),
        достопримечательности(_, Название_достопримечательности, Название_столицы),
        write("Нахождение части света по достопримечательности: ", Часть_света),
        nl,
        fail.

    население_столиц_в_зад_части_света(Часть_света) :-
        расположение(Название_столицы, Часть_света),
        столица(_, Название_столицы, Население),
        s(Sum),
        assert(s(Sum + Население)),
        fail.

    население_столиц_в_зад_части_света(Часть_света) :-
        расположение(_, Часть_света),
        s(Sum),
        write("Вывод населения столиц в данной части света: ", Sum),
        nl,
        !.

    список_столиц() = Список_столиц :-
        Список_столиц = [ Название_столицы || столица(_, Название_столицы, _) ].

    список_населения_государств() = Список_населения :-
        Список_населения = [ Население || государство(_, _, _, Население) ].

    поиск_государства(Название_гос) = Результат :-
        государство(_, Название_гос, _, _),
        Результат = true.

    run() :-
        console::init(),
        reconsult("..\\yulia.txt", worldDb),
        fail.

    run() :-
        console::init(),
        reconsult("..\\yulia.txt", worldDb),
        столица_по_части_света("Азия").

    run() :-
        console::init(),
        reconsult("..\\yulia.txt", worldDb),
        вывод_населения_гос(япония).

    run() :-
        console::init(),
        reconsult("..\\yulia.txt", worldDb),
        столица_страны(япония).

    run() :-
        console::init(),
        reconsult("..\\yulia.txt", worldDb),
        достопримечательность_столицы("Токио").

    run() :-
        console::init(),
        reconsult("..\\yulia.txt", worldDb),
        где_достопримечательность("Собор Святого Вита").

    run() :-
        console::init(),
        reconsult("..\\yulia.txt", worldDb),
        население_столиц_в_зад_части_света("Европа"),
        fail.

    run() :-
        console::init(),
        reconsult("..\\yulia.txt", worldDb),
        список_столиц() = Список,
        write("Список столиц: ", Список),
        nl,
        fail.

    run() :-
        console::init(),
        reconsult("..\\yulia.txt", worldDb),
        список_населения_государств() = Список,
        write("Список населения государств: ", Список),
        nl,
        fail.

    run() :-
        console::init(),
        reconsult("..\\yulia.txt", worldDb),
        поиск_государства(украина) = Результат,
        write("Результат поиска государства: ", Результат),
        nl,
        fail.
    run() :-
        stdio::write("\nКонец работы программы :-)\n").

end implement main

goal
    console::runUtf8(main::run).
