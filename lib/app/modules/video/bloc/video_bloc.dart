import 'package:flutter_bloc/flutter_bloc.dart';

import '../repositories/video_repository.dart';

import 'events/video_events.dart';
import 'states/video_states.dart';

class VideoBloc extends Bloc<VideoEvents, VideoStates> {
  final IVideoRepository repository;
  VideoBloc(this.repository) : super(VideoIdle()) {
    on<GetVideo>(getVideo);
  }

  getVideo(GetVideo event, Emitter emit) async {
    emit(VideoLoading());
    final result = await repository(event.videoId);
    emit(VideoSucess(result));
  }
}
