create or replace function unistr_js(str varchar2) return varchar2 is
  --功能：转换js的unicode编码为对应的可显示字符, 例如 \u6697\u9ed1\u96c5\u5178\u5a1c
  --作者：DarkAthena
  --Email:darkathena@qq.com
  /*
Copyright DarkAthena

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
  outstr varchar2(32000);
  n      number;
begin
  n := 0;
  for i in 1 .. length(str) loop
    if n > 0 then
      n := n + 1;
      if n = 7 then
        n := 0;
      else
        continue;
      end if;
    end if;
    if regexp_like(substr(str, i, 6), '\\u[0-9a-fA-F]{4}') then
      outstr := outstr || unistr(replace(substr(str, i, 6), '\u', '\'));
      n      := 1;
    else
      outstr := outstr || substr(str, i, 1);
    end if;
  end loop;
  return(outstr);
end unistr_js;
/
