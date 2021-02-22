import { MessageDto } from './model/message-dto';
import { Observable } from 'rxjs';
import { Body, Controller, Get, Post } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get('')
  public hello(){
    return "hello msg api";
  }
  
  @Post('/sendMessage')
  sendMessage(@Body() message: MessageDto): Observable<Object>{
    return this.appService.sendMessages(message);
  }
}
