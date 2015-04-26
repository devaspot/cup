-module(uu_people).
-compile(export_all).
-include("uu.hrl").

all() -> [

   {{"dmytro-yarosh",en}, #user{id="dmytro-yarosh",name= <<"Dmytro Yarosh"/utf8>>,
                             city = <<"DP">>,profession = <<"Лідер української праворадикальної організації \"Правий Сектор\""/utf8>>,
                             photo= "/static/people/dmytro-yarosh/image.jpg" }},

   {{"dmytro-yarosh",ua}, #user{id="dmytro-yarosh",name= <<"Дмитро Ярош"/utf8>>,
                             city = <<"DP">>,profession = <<"Лідер української праворадикальної організації \"Правий Сектор\""/utf8>>,
                             photo= "/static/people/dmytro-yarosh/image.jpg" }},

   {{"dmytro-yarosh",ru}, #user{id="dmytro-yarosh",name= <<"Дмитрий Ярош"/utf8>>,
                             city = <<"DP">>,profession = <<"Лидер украинской праворадикальной организации \"Правый Сектор\""/utf8>>,
                             photo= "/static/people/dmytro-yarosh/image.jpg" }},

   {{"oleg-gubar",en}, #user{id="oleg-gubar",name= <<"Oleg Gubar"/utf8>>,
                             city = <<"ZH">>,profession = <<"Historian of the City of Odessa"/utf8>>,
                             photo= "/static/people/oleg-gubar/image.jpg" }},

   {{"oleg-gubar",ua}, #user{id="oleg-gubar",name= <<"Олег Губар"/utf8>>,
                             city = <<"ZH">>,profession = <<"Історик міста Одеса"/utf8>>,
                             photo= "/static/people/oleg-gubar/image.jpg" }},

   {{"oleg-gubar",ru}, #user{id="oleg-gubar",name= <<"Олег Губар"/utf8>>,
                             city = <<"ZH">>,profession = <<"Историк города Одесса"/utf8>>,
                             photo= "/static/people/oleg-gubar/image.jpg" }},

   {{"andrey-volokita",ua}, #user{id="andrey-volokita",name= <<"Андрій Волокита"/utf8>>,
                             city = <<"KH">>,profession = <<"Підприємець"/utf8>>,
                             photo= "/static/people/andrey-volokita/image.jpg" }},

   {{"andrey-volokita",en}, #user{id="andrey-volokita",name= <<"Andrey Volokita"/utf8>>,
                             city = <<"KH">>,profession = <<"Enterpreneur"/utf8>>,
                             photo= "/static/people/andrey-volokita/image.jpg" }},

   {{"andrey-volokita",ru}, #user{id="andrey-volokita",name= <<"Андрей Волокита"/utf8>>,
                             city = <<"KH">>,profession = <<"Предприниматель"/utf8>>,
                             photo= "/static/people/andrey-volokita/image.jpg" }},

   {{"arina-koltsova",en}, #user{id="arina-koltsova",name= <<"Arina Koltsova"/utf8>>,
                             city = <<"ZH">>,profession = <<"Unknown"/utf8>>,
                             photo= "/static/people/arina-koltsova/image.jpg" }},

   {{"arina-koltsova",ru}, #user{id="arina-koltsova",name= <<"Арина Кольцова"/utf8>>,
                             city = <<"ZH">>,profession = <<"Unknown"/utf8>>,
                             photo= "/static/people/arina-koltsova/image.jpg" }},

   {{"arina-koltsova",ua}, #user{id="arina-koltsova",name= <<"Арiна Кольцова"/utf8>>,
                             city = <<"ZH">>,profession = <<"Unknown"/utf8>>,
                             photo= "/static/people/arina-koltsova/image.jpg" }},

   {{"dima-gavrysh",en}, #user{id="dima-gavrysh",name= <<"Dima Gavrysh"/utf8>>,
                             city = <<"ZH">>,profession =
        <<"Dima Gavrysh is a US-based visual artist who for "
          "the past six years has been exploring the American "
          "and Soviet invasions of Afghanistan through video "
          "installation, photography, appropriated imagery "
          "and data visualization."/utf8>>,
                             photo= "/static/people/dima-gavrysh/image.jpg" }},

   {{"dima-gavrysh",ua}, #user{id="dima-gavrysh",name= <<"Діма Гавриш"/utf8>>,
                             city = <<"ZH">>,profession =
        <<"Діма Гавриш — україно-американський інтердисциплінарний"
          " художник, який протягом останніх шести років займався "
          "вивченням американського і радянського вторгнень до "
          "Афганістану з допомогою відеоінсталяції, фотографії, "
          "аппропіірованних зображень і візуалізації даних."/utf8>>,
                             photo= "/static/people/dima-gavrysh/image.jpg" }},


   {{"dima-gavrysh",ru}, #user{id="dima-gavrysh",name= <<"Діма Гавриш"/utf8>>,
                             city = <<"ZH">>,profession =
        <<"Дима Гавриш - украино-американский интердисциплинарный "
        "художник, который на протяжении последних шести лет "
        "занимался изучением американского и советского вторжений "
        "в Афганистан с помощью видеоинсталляции, фотографии, "
        "аппропиированных изображений и визуализации данных."/utf8>>,
                             photo= "/static/people/dima-gavrysh/image.jpg" }}



].

lookup(Key) ->
    [ ets:insert(globals,X) || X <- uu_people:all() ],
    Res = ets:lookup(globals,Key),
    case Res of
         [] -> [];
         [Value] -> Value;
         Values -> Values end.

