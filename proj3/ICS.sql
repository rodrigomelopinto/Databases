create or replace function cat_fun() returns
  trigger as $$
  declare c integer;
  begin
    select count(*) into c from tem_outra where tem_outra.super_categoria = new.categoria;
    if c > 0 then
      raise exception 'Uma categoria não pode estar contida em si propria'
      using hint = 'Por favor verifique o nome da categoria.';
    end if;
    return new;
  end;
$$ language plpgsql;

create trigger cat_trg before update on tem_outra for each row execute procedure cat_fun();

create trigger cat_trg_i before insert on tem_outra for each row execute procedure cat_fun();

create or replace function uni_fun() returns
  trigger as $$
  declare c integer;
  begin
    select count(*) into c from evento_reposicao where new.unidades > (select unidades from planograma where ean = new.ean);
    if c > 0 then
      raise exception 'O numero de unidades repostas num Evento de Reposição não pode exceder o número de unidades especificado no Planograma'
      using hint = 'Por favor verifique o número de unidades a repor.';
    end if;
    return new;
  end;
$$ language plpgsql;

create trigger uni_trg before update on evento_reposicao for each row execute procedure uni_fun();

create trigger uni_trg_i before insert on evento_reposicao for each row execute procedure uni_fun();

create or replace function pro_fun() returns
  trigger as $$
  declare c integer;
  begin
    select count(*) into c from planograma  where new.ean = (select ean from tem_categoria where tem_categoria.nome = (select nome from prateleira where new.nro = nro));
    if c = 0 then
      raise exception 'Um Produto só pode ser reposto numa Prateleira que apresente (pelo menos) uma das Categorias desse produto'
      using hint = 'Por favor verifique a prateleira.';
    end if;
    return new;
  end;
$$ language plpgsql;

create trigger pro_trg before update on planograma for each row execute procedure pro_fun();

create trigger pro_trg_i before insert on planograma for each row execute procedure pro_fun();
