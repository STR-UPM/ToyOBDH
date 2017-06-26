------------------------------------------------------------------------------
--                                                                          --
--          Copyright (C) 2017, Universidad Politécnica de Madrid           --
--                                                                          --
--  Redistribution and use in source and binary forms, with or without      --
--  modification, are permitted provided that the following conditions are  --
--  met:                                                                    --
--     1. Redistributions of source code must retain the above copyright    --
--        notice, this list of conditions and the following disclaimer.     --
--     2. Redistributions in binary form must reproduce the above copyright --
--        notice, this list of conditions and the following disclaimer in   --
--        the documentation and/or other materials provided with the        --
--        distribution.                                                     --
--     3. Neither the name of the copyright holder nor the names of its     --
--        contributors may be used to endorse or promote products derived   --
--        from this software without specific prior written permission.     --
--                                                                          --
--   THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS    --
--   "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT      --
--   LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR  --
--   A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT   --
--   HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, --
--   SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT       --
--   LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,  --
--   DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY  --
--   THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT    --
--   (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE  --
--   OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.   --
--                                                                          --
------------------------------------------------------------------------------

--  This implementation uses IP sockets. The task listens on an IP port,
--  and when a telecommand arrives it executes it.

--  The port address is defined in the IP package. Edit and recompile
--  if necessary.

with IP;

with HK_TM;

with Ada.Real_Time;           use Ada.Real_Time;
with Ada.Streams;             use Ada.Streams;
with Ada.Characters.Handling; use Ada.Characters.Handling;
with GNAT.Sockets;            use GNAT.Sockets;

with Ada.Unchecked_Conversion;

pragma Warnings(Off);
with System.IO; -- for debugging
pragma Warnings (On);

package body TC_Receiver is -- sporadic

   task body TC_Receiver_Task is

      Socket   : Socket_Type;
      Address  : Sock_Addr_Type;
      From     : Sock_Addr_Type;

      subtype TC_Stream is
        Stream_Element_Array (1..TC_Message'Size/8); -- bytes
      function To_TC_Message is new Ada.Unchecked_Conversion
        (TC_Stream, TC_Message);

      Data : TC_Stream;
      Last : Ada.Streams.Stream_Element_Offset;

   begin
      delay until Clock + Milliseconds(Start_Delay);

      -- Create UDP socket
      Create_Socket(Socket, Family_Inet, Socket_Datagram);

      -- Local address for receiving TC
      Address := (Family => Family_Inet,
                  Addr   => Any_Inet_Addr,
                  Port   => Port_Type(IP.TC_Port));
      Bind_Socket (Socket, Address);

      pragma Debug (System.IO.Put_Line("... listening on port "
                    & Address.Port'Img));
      -- Get telecommands
      loop
         Receive_Socket (Socket, Data, Last, From);
         declare
            Command : TC_Message :=  To_TC_Message(Data);
         begin
            -- System.IO.Put_Line("TC " & Command.Kind'Img);
            case Command.Kind is
               when HK =>
                  HK_TM.Send;
               when others =>
                  null;
            end case;
         end;
      end loop;

   end TC_Receiver_Task;

end TC_Receiver;
