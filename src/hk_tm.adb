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

with Measurements;   use Measurements;
with TM;             use TM;
with Buffer;
with Ada.Real_Time;  use Ada.Real_Time;

package body HK_TM is -- sporadic

   -------------------------
   -- Internal operations --
   -------------------------

   procedure Send_HK_Data;

   ------------------
   -- Request body --
   ------------------

   protected body Request is

      procedure Signal is
      begin
         Pending := True;
      end Signal;

      entry Wait when Pending is
      begin
         Pending := False;
      end Wait;

   end Request;

   ---------------------
   -- HK_TM_Task body --
   ---------------------

   task body  HK_TM_Task is
   begin
      loop
         Request.Wait;
         Send_HK_Data;
      end loop;
   end HK_TM_Task;

   ------------------
   -- Send_HK_Data --
   ------------------

   procedure Send_HK_Data is
      M       : Measurement;
      Message : TM_Message(Housekeeping);
   begin
      Message.Timestamp := Clock;
      for I in Message.Data_Log'Range loop
         exit when Buffer.Empty;
         Buffer.Get(M);
         Message.Data_Log(I) := M;
         Message.Length := I;
      end loop;
      TM.Send(Message);
   end Send_HK_Data;

end HK_TM;
