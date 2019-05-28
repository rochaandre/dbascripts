set feedback off
set lines 200
set serveroutput on size 9999
DECLARE
v_var number;
FUNCTION oratop(hsize in number, vsize in number)
RETURN NUMBER
is
begin
  dbms_output.enable(9999999);
     dbms_output.put_line('System: ' );

  for a in
    (select
          rpad(host_name, hsize - 40) host_name
       ,  rpad(instance_name, hsize - 49) instance_name
       ,  to_char(sysdate, 'HH24:MI:SS DD-MON-YY') currtime
       ,  to_char(startup_time, 'HH24:MI:SS DD-MON-YY') starttime
     from v$instance) loop

     dbms_output.put_line('System: ' || a.host_name || 'System time: ' || a.currtime);
     dbms_output.put_line('Instance: ' || a.instance_name || 'Inst start-up time: ' || a.starttime );
  end loop;

  for b in
    (select total, active, inactive, system, killed
    from
       (select count(*) total from v$session)
     , (select count(*) system from v$session where username is null)
     , (select count(*) active from v$session where status = 'ACTIVE' and username is not null)
     , (select count(*) inactive from v$session where status = 'INACTIVE')
     , (select count(*) killed from v$session where status = 'KILLED')) loop

     dbms_output.put_line(b.total || ' sessions: ' || b.inactive || ' incactive, ' || b.active || ' active, ' || b.system || ' system, ' || b.killed || ' killed');
  end loop;

  dbms_output.put_line( chr(13) );

  dbms_output.put_line( 'SID/SERIA  DB USER    OSUSER     SPID    PID  LASTCALL STATE    TERMINAL   COMMAND');
  dbms_output.put_line( '--------- ---------- ---------- ------- ---- -------- -------- ----------' || rpad(' ', hsize - 73, '-'));

  for x in
    (select * from (select
       rpad(lower(status), 9) st
    ,  rpad(sid || ',' || sess.serial#, 10) sid
    ,  to_char(sysdate - (last_call_et / 86400),'HH24:MI:SS') la
    ,  to_char(LOGON_TIME,'HH24:MI:SS') lt
    ,  rpad(substr(lower(sess.username), 1, 10), 10) usr
    ,  rpad(substr(nvl(lower(osuser  ), 'n/a'), 1, 10), 10) osu
    ,  rpad(substr(nvl(lower(P.spid ), 'n/a'), 1, 7), 7) ospid
    ,  rpad(lower(decode(lower(trim(p.pid)), 'unknown', substr(p.pid, 1, instr(p.pid, '.')-1), null, p.pid, p.pid)),4) pid
    ,  rpad(lower(decode(lower(trim(sess.terminal)), 'unknown', substr(sess.machine, 1, instr(sess.machine, '.')-1), null, sess.machine, sess.terminal)),10) mcn
    ,  rpad(substr(nvl(lower(trim(sess.program||' '||action
    )), 'n/a'), 1, hsize - 80), hsize - 80) prg
   from v$session sess, v$process p
   where sess.username is not null
   and sess.paddr=P.addr
   order by st,(select 	sum(value) from v$sesstat where statistic# in (12,40,43) and sid = sess.sid) desc, la desc)
   where rownum < vsize - 7) loop

   dbms_output.put_line(x.sid||x.usr||' '||x.osu ||' '||x.ospid||' '||x.pid||' '||x.la||' '||x.st||x.mcn||' '||x.prg);
  end loop;
  return null;
end;
BEGIN
--v_var := oratop(${hsize}, ${vsize});
v_var := oratop(80, 40);
END;
/
