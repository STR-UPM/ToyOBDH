--------------------------------------------------------------------------------
-- $Id$
-- Project OBDH
-- Main procedure body
-- Copyright (c) 2017 Juan Antonio de la Puente <jpuente@dit.upm.es>
-- Permission to copy and modify are granted under the terms of
-- the GNU General Public License (GPL).
-- See http://www.gnu.org/licenses/licenses.html#GPL for the details
--------------------------------------------------------------------------------
--with Reader_Task, Basic_TM_Task, HK_TM_Task, TC_Task;
with Reader_Task, Basic_TM_Task, HK_TM_Task, Keyboard;
with System.IO;
procedure OBDH is
begin
   System.IO.Put_Line("--- OBDH System started ---");
   -- do nothing while application tasks run
end OBDH;
