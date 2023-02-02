_G["readme"][[


     ----------------------------------------------------------------------------------------
                                      SummerTYT's Tycoon 1.0
     ----------------------------------------------------------------------------------------

     Este es un proyecto que comence para probar mis habilidades de programador, aunque mucho
     de lo que esta escrito dentro del codigo parece simple.
     
     Esto se creo como un remake de los Tycoons que circulan en la librerias de la comunidad
     de roblox, utilizando el sistema de :GetAttribute() y :SetAttribute() es posible crear
     un sistema flexible y que no requiera tantos conocimientos de codigo.
     
     Muchas de las configuraciones se pueden realizar desde los mismos atributos de los
     objetos adjuntados como los Droppers, Upgraders, Conveyors, etc.

     Para dejar en claro algunas cosas antes de confundirse, aqui les tengo una explicacion
     sencilla:

     Grupos     ->     Modelo:    Contiene el aspecto y forma del Grupo
                ->     Parte:     Es un objeto tipo "Part", se utiliza generalmente para establecer
                                  el codigo base del Grupo asociado

     Bloque     ->     Es la entidad base para que funcione todo el Tycoon

     Toda la configuracion necesaria la pueden hacer modificando los Atributos de los grupos.
     Aqui una lista de los atributos que pueden modificar a su gusto.





     ----------------------------------------------------------------------------------------

                                         Collectors

     ----------------------------------------------------------------------------------------
     
     Los Collectors son los objetos que recogen el dinero generado por los Droppers y los
     Upgraders, no hay mucha logica detras de esto.
     
     Atributos:
     String - "_model"           :      Este atributo es para referenciar que modelo utilizar
                                        dentro del codigo, util para cuando se quieran hacer
                                        cambios.

     Booleano - "isCollector"    :      Establece que el Grupo es un tipo Dropper.





     ----------------------------------------------------------------------------------------

                                         Droppers

     ----------------------------------------------------------------------------------------

     Los Droppers son objetos que dropean bloques que se pueden vender.

     Atributos:
     String - "_model"           :      Este atributo es para referenciar que modelo utilizar
                                        dentro del codigo, util para cuando se quieran hacer
                                        cambios.

     String - "_removemodel"     :      Este atributo es para referenciar que modelo se borrara,
                                        esto es util cuando hayan botones que quieran borrar X cosa.

     Number - "BlockDelay"       :      Cuanto tiempo habra en segundos por cada vez que el Dropper
                                        vaya a crear un bloque.

     Number - "blockRemove"      :      En cuanto tiempo/segundos el bloque creado por el Dropper
                                        sera eliminado (Util cuando se tiene Conveyers largos)

     Number - "blockSpawnOffset" :      Cuanto es la distancia que creata el bloque del Dropper.

     Number - "blockValue"       :      Que valor tendra el bloque creado por el Dropper.

     Booleano - "enabled"        :      Si esta desactivado, el bloque asociado no aparecera al
                                        inicio, util para declarar los bloques para comenzar.

     Booleano - "isDropper"      :      Establece que el Grupo es un tipo Dropper.

     Booleano - "buyed"          :      (Solo Desarrollador) Establece si el modelo fue comprado
                                        o no. Esto solo existe para que la funcion
                                        GetAttributeChangedSignal() funcione apropiadamente





     ----------------------------------------------------------------------------------------

                                          Conveyors

     ----------------------------------------------------------------------------------------

     Los Conveyors son transportadores que llevan los bloques hasta el Seller.

     Atributos:
     String - "_model"           :      Este atributo es para referenciar que modelo utilizar
                                        dentro del codigo, util para cuando se quieran hacer
                                        cambios.

     String - "_removemodel"     :      Este atributo es para referenciar que modelo se borrara,
                                        esto es util cuando hayan botones que quieran borrar X cosa.

     Number - "speed"            :      Establece la velocidad del Conveyer.


     Booleano - "enabled"        :      Si esta desactivado, el bloque asociado no aparecera al
                                        inicio, util para declarar los bloques para comenzar.

     Booleano - "isConveyor"     :      Establece que el Grupo es un tipo Conveyor.

     Booleano - "buyed"          :      (Solo Desarrollador) Establece si el modelo fue comprado
                                        o no. Esto solo existe para que la funcion
                                        GetAttributeChangedSignal() funcione apropiadamente





     ----------------------------------------------------------------------------------------

                                            Sellers

     ----------------------------------------------------------------------------------------

     Los Sellers son los objetos que venden los bloques, para establecer cuanto vendera un
     bloque, los precios se modifican en los Droppers y en los Upgraders.

     Atributos:
     String - "_model"           :      Este atributo es para referenciar que modelo utilizar
                                        dentro del codigo, util para cuando se quieran hacer
                                        cambios.

     String - "_removemodel"     :      Este atributo es para referenciar que modelo se borrara,
                                        esto es util cuando hayan botones que quieran borrar X cosa.

     Booleano - "enabled"        :      Si esta desactivado, el bloque asociado no aparecera al
                                        inicio, util para declarar los bloques para comenzar.

     Booleano - "isConveyor"     :      Establece que el Grupo es un tipo Conveyor.

     Booleano - "buyed"          :      (Solo Desarrollador) Establece si el modelo fue comprado
                                        o no. Esto solo existe para que la funcion
                                        GetAttributeChangedSignal() funcione apropiadamente





     ----------------------------------------------------------------------------------------

                                           Upgraders

     ----------------------------------------------------------------------------------------
     
     Los upgraders añaden multiplicadores a los bloques, es recomendable añadir multiplicado-
     res en rangos de 0.5 a 4, ya que los bloques vienen por defecto con un mutliplicador de
     1.
     
     La logica de como funcionan es que al llegar a los Sellers, el Seller calcula el precio
     final de esta forma:
     
     Precio Final = Precio del bloque x Multiplicador
     
     Por ejemplo:
     
     10 x 1.5     da     15
     20 x 2       da     20
      1 x 30      da     30


     Atributos:
     String - "_model"           :      Este atributo es para referenciar que modelo utilizar
                                        dentro del codigo, util para cuando se quieran hacer
                                        cambios.

     Booleano - "enabled"        :      Si esta desactivado, el bloque asociado no aparecera al
                                        inicio, util para declarar los bloques para comenzar.

     Booleano - "isUpgrader"     :      Establece que el Grupo es un tipo Upgrader.

     Booleano - "buyed"          :      (Solo Desarrollador) Establece si el modelo fue comprado
                                        o no. Esto solo existe para que la funcion
                                        GetAttributeChangedSignal() funcione apropiadamente





     ----------------------------------------------------------------------------------------

                                              Walls

     ----------------------------------------------------------------------------------------
     
     Los Walls o tambien llamado paredes, son objetos estaticos del tycoon, puedes crear est-
     ucturas u paredes, las paredes son meramente decorativas.
     
     Atributos:
     String - "_model"           :      Este atributo es para referenciar que modelo utilizar
                                        dentro del codigo, util para cuando se quieran hacer
                                        cambios.

     String - "_removemodel"     :      Este atributo es para referenciar que modelo se borrara,
                                        esto es util cuando hayan botones que quieran borrar X cosa.

     Booleano - "enabled"        :      Si esta desactivado, el bloque asociado no aparecera al
                                        inicio, util para declarar los bloques para comenzar.

     Booleano - "isWall"         :      Establece que el Grupo es un tipo Wall.

     Booleano - "buyed"          :      (Solo Desarrollador) Establece si el modelo fue comprado
                                        o no. Esto solo existe para que la funcion
                                        GetAttributeChangedSignal() funcione apropiadamente




     ----------------------------------------------------------------------------------------
                                    Preguntas y Respuestas
     ----------------------------------------------------------------------------------------

     P: ¿Que pasa si el sistema Summer Tycoon se actualiza? ¿Debo borrar todo y comenzar de-
     nuevos?
     
          R:      No, el sistema Summer Tycoon es totalmente automatico, solo debes de
                  actualizar el archivo principal "MainScript", ese archivo es la base
                  total de todo el sistema.



     P: El juego esta roto/no funciona y veo mensajes de error.
     
          R:      Asegurate de haber colocado todo el contenido de "Mover a
                  ServerScriptService" y "Mover a ReplicatedStorage" en sus respectivos
                  lugares, si sigue funcionando mal, envia un comentario.



     P: ¿Donde puedo modificar el funcionamiento base de los Droppers y demas objetos?
     
          R:      Dentro de la carpeta "Main" y "MainScript", encontraras el codigo
                  de cada objeto, puedes modificar esos y el sistema Summer Tycoon
                  copiara el codigo y pegarlo en sus respectivos objetos.



     P: No encuentro el script para los botones. ¿Donde esta?
     
          R:      En el script "MainScript" esta el codigo de los botones, esto es asi
                  debido a limitaciones.



     P: ¿Que diferencia hay de este sistema de los que ya existen?
     
          R:      En contenido, no hay diferencia alguna, todos tienen Droppers,
                  Upgraders, Conveyers y demas cosas.
                  Aun asi, en sentido de configuración, el sistema Summer Tycoon es mas
                  flexible y facil de modificar, ademas es automatico, lo que significa
                  que si haces un cambio o añades muchas cosas, el mismo sistema se
                  encargara de colocar el codigo correspondiente en sus respectivos
                  grupos.
]]
