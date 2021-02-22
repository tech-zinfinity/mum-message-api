import { MessageDto } from './model/message-dto';
import { HttpService, Injectable } from '@nestjs/common';
import { Observable } from 'rxjs';
import { forkJoin } from 'rxjs';

@Injectable()
export class AppService {

  constructor(private http: HttpService){}

  
  sendMessages(messagedto: MessageDto) : Observable<Object>{
    return new Observable(obs =>{
      let list:Observable<any>[] = [] ;
      messagedto.numbers.forEach(num=>{
        list.push(this.sendMessage(num, messagedto.message));
      });
      forkJoin(list).subscribe((s:any) =>{
        s.forEach((e:any)=>{          
          obs.next(e.data);
        })
      },err=>{
        console.log(err);
      },()=>{
        obs.complete();
      })
    });
  }

  sendMessage(number: string, msg: string): Observable<any>{
    return this.http.get("https://www.allroutetech.co.in/sendsms/bulksms.php"
    +"?username=alart&password=Time&type=TEXT&sender=UNIMSG&"
    +"mobile=+91"+number+"&message="+msg);
  }
}
