import 'package:dio/dio.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:untitled5/characters_state.dart';
import 'package:untitled5/model/characters/characters.dart';




class FetchCharacterProvider extends StateNotifier<FetchcharactersState>{
  FetchCharacterProvider(super.state);

 fetchcharacters()async{
    state=FetchcharactersState.fetching();
    try {
      Dio dio = Dio();
      var response = await dio.post('https://rickandmortyapi.com/graphql',
          data
    :{
    'query':r'''
        query {
         characters{
               results{
                           id
                           name
                           image
                           status
            }
  }
}


        '''
    }

      );

      List<dynamic> responsedata=response.data['data']['characters']['results'];
      state=FetchcharactersState.fetched(responsedata.map((e) =>Character.fromJson(e)).toList());
      

    }
    on DioException
    catch(e
    ){
      state=FetchcharactersState.failed("failed to conneect");
    }
  }
}