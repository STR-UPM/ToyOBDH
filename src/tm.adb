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

--  The implementation of the TM package uses sockets to send telemetry
--  messages to the ground station. The IP address and port to which the
--  messages are sent are defined in the IP package. Edit and recompile
--  as necessary to adapt to the real GS address.

with IP;

with Measurements;    use Measurements;

with Ada.Streams;     use Ada.Streams;
with GNAT.Sockets;    use GNAT.Sockets;

with Ada.Unchecked_Conversion;

with System;

pragma Warnings(Off);
with System.IO; -- for debugging
pragma Warnings(On);

package body TM is

   ----------------------------------
   -- Transmitter protected object --
   ----------------------------------

   protected Transmitter
     with Priority => System.Priority'Last
   -- replace with ceiling priority when available
   is
      procedure Send (Message : TM_Message);
   end Transmitter;
   --  The send operation is encapsulated in a protected object because
   --  it can be called by the Basic_TM and Log_TM tasks.

   ----------
   -- Send --
   ----------

   procedure Send (Message : TM_Message) is
   begin
      Transmitter.Send(Message);
   end Send;

   --------------------------
   --  Internal procedures --
   --------------------------

   procedure Send_Socket (Message : TM_Message);
   -- Send a message trough an IP socket

   ----------------------
   -- Transmitter body --
   ----------------------

   protected body Transmitter is

      procedure Send (Message : TM_Message) is
      begin
         Send_Socket (Message);
      end Send;

   end Transmitter;

   -----------------
   -- Send_Socket --
   -----------------

   procedure Send_Socket (Message : TM_Message) is

      Socket         : Socket_Type;
      GS_Address     : Sock_Addr_Type;

      subtype TM_Stream is
        Ada.Streams.Stream_Element_Array (1..TM_Message'Size/8);

      function To_Stream is new Ada.Unchecked_Conversion
        (TM_Message, TM_Stream);

      Stream : TM_Stream := To_Stream(Message);
      Last   : Ada.Streams.Stream_Element_Offset;

   begin
      -- Create UDP socket
      Create_Socket (Socket, Family_Inet, Socket_Datagram);

      -- Destination address for TM
      GS_Address := (Family => Family_Inet,
                     Addr   => IP.GS_IP,
                     Port   => IP.GS_Port
                    );

      -- Send message
      Send_Socket(Socket, Stream, Last, GS_Address);
      Close_Socket(Socket);

      -- Log message
      case Message.Kind is
         when Basic =>
            pragma Debug (System.IO.Put_Line("TM " & Message.Data.Value'Img));
         when Housekeeping =>
            pragma Debug (System.IO.Put_Line("HK ---------"));
            for i in 1..Message.Length loop
               pragma Debug (System.IO.Put_Line("      "
                             & Message.Data_Log(i).Value'Img));
            end loop;
            pragma Debug (System.IO.Put_Line("-------------"));
      end case;

   end Send_Socket;

end TM;
