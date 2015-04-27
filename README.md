Ukraine United
==============

Features
--------

* N2O DTL/SPA Application
* Static HTML Generation
* Static JSON Generation
* Dynamic REST
* Dynamic DTL
* Active Reloading
* Built-in Web Server

You could keep static JSON files and dynamic REST
endpoint (which is able to add/remove interviews)
booth at the same time or you can you inly one of them.
Same with static HTML and dynamic DTL page generation.

Prerequisites
-------------

* Erlang
* make

Start
-----

```sh
   make console
```

And open it in browser [http://localhost:8820](http://localhost:8820)

Usage
-----

From Erlang:

```erlang
> interview:get("2014-12.oleg-gubar.en").
#interview{id = "2014-12.oleg-gubar.en",date = "2014-12",
           title = undefined,
           text = <<"Oleg Gubar\nOdessa\nHistorian of the City of Odessa\n\nIn general, I don’t concern myself with polit"/utf8...>>,
           author = "oleg-gubar"}

> uu:ls().
[{"2014-07","andrey-volokita","en"},
 {"2014-07","arina-koltsova","en"},
 {"2014-12","oleg-gubar","en"}]

> uu:time().
[{"2013-11-21",<<"Mustafa Nayem issued a call to">>},
 {"2013-11-22",<<"The number of people increases">>},
 {"2013-11-23",<<"To install the city New Year t">>},
 {"2013-11-24",<<"The tent camp is installed at ">>},
 {"2013-11-25",<<"The tent camp continues to exi">>},
 {"2013-11-26",<<"The association of two “maid"/utf8>>},
 {"2014-1-19",<<"About 100 – 500 of demon"/utf8...>>},
 {"2014-1-20",<<"The opposition on Hr"...>>},
 {"2014-1-22",<<"The activists Se"...>>},
 {"2014-1-10",<<"Prime Minist"...>>},
 {"2014-2-12",<<"Yanukovy"...>>},
 {"2014-2-17",<<"“Rig"/utf8...>>},
 {"2014-2-18",<<...>>},
 {[...],...},
 {...}|...]

> interview:get().
[#interview{id = "2014-07.andrey-volokita.en",
            date = "2014-07",title = undefined,
            text = <<"Andrey Volokita\nKharkiv\nEnterpreneur\n\nThe views of Kharkovites [citizens of Kharkov, a city "...>>,
            author = "andrey-volokita"},
 #interview{id = "2014-07.arina-koltsova.en",
            date = "2014-07",title = undefined,
            text = <<"Arina Koltsova\nKiev\nHead of the “Samooborona” of Solomyansky district of Kiev\n\nI arrived"/utf8...>>,
            author = "arina-koltsova"},
 #interview{id = "2014-12.oleg-gubar.en",date = "2014-12",
            title = undefined,
            text = <<"Oleg Gubar\nOdessa\nHistorian of the City of Odessa\n\nIn general, I don’t concern mysel"/utf8...>>,
            author = "oleg-gubar"}]
```

From REST clients:

```sh
$ curl -I -X GET http://localhost:8820/json/en/2014-07.andrey-volokita.json
$ curl -I -X GET http://localhost:8820/rest/interview/2014-12.oleg-gubar.en
$ curl -I -X GET http://localhost:8820/static/interviews/2014-12.oleg-gubar.en.txt
$ curl -I -X GET http://localhost:8820/static/timeline/2013-11/21-en.txt
```

Credits
-------

* Dima Gavrysh
* Yurii Artyukh
* Maxim Sokhatsky
