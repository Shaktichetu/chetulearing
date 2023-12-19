import 'package:demo_animate/implicit_animation/animated_container_example.dart';
import 'package:demo_animate/implicit_animation/animated_crossfade_example.dart';
import 'package:demo_animate/implicit_animation/animated_list_example.dart';
import 'package:demo_animate/implicit_animation/animated_physical_model_example.dart';
import 'package:demo_animate/implicit_animation/animated_positioned_directional_example.dart';
import 'package:demo_animate/implicit_animation/animated_positioned_example.dart';
import 'package:demo_animate/implicit_animation/animated_switcher.dart';
import 'package:demo_animate/implicit_animation/animated_text_size.dart';
import 'package:demo_animate/implicit_animation/positioned_transition_example.dart';
import 'package:demo_animate/implicit_animation/size_transition_example.dart';
import 'package:demo_animate/page_transitions/fade_page_transition.dart';
import 'package:demo_animate/page_transitions/page_rotation_transition.dart';
import 'package:demo_animate/page_transitions/page_scale_transition.dart';
import 'package:demo_animate/page_transitions/page_size_transation.dart';
import 'package:demo_animate/page_transitions/page_slide_transition.dart';
import 'package:demo_animate/page_transitions/page_two.dart';
import 'package:flutter/material.dart';
import 'explicit_animation/animated_builder_example.dart';
import 'explicit_animation/rotational_transition.dart';
import 'implicit_animation/animated_align_example.dart';
import 'implicit_animation/animated_opacity.dart';
import 'implicit_animation/animated_padding_example.dart';
import 'more_animations/custom_paint_animation.dart';
import 'more_animations/lottie_slider_example.dart';
import 'more_animations/rive_slider.dart';
import 'page_transitions/page_mix_rotate_transition.dart';
import 'page_transitions/page_mixed_fade_transition.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}
//
class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: const Text("Flutter Animation course")),
    body: Center(child: ListView(
      physics: const BouncingScrollPhysics(),
      children: [
      ElevatedButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AnimatedAlignExamle()),
        );
      }, child: const Text("Animated Align")),
      ElevatedButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AnimatedContainerExample()),
        );
      }, child: const Text("Animated Container")),
    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => const AnimatedTextSize()),
        );
      }, child: const Text("Animated Text Size")),
      ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const AnimatedOpacityExample()),
        );
      }, child: const Text("Animated Opacity")),
    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const AnimatedPaddingExample()),
        );
      }, child: const Text("Animated Padding")),
    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const AnimatedPhysicalModelExample()),
        );
      }, child: const Text("Animated physical model")),
     ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const AnimatedPositionedExample()),
        );
      }, child: const Text("Animated positioned example")),
    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const AnimatedPositionedDirectionalExample()),
        );
      }, child: const Text("Animated positioned directional example")),
    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const AnimatedCrossFadeExample()),
        );
      }, child: const Text("Animated cross fade example")),

    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const AnimatedSwtcherExample()),
        );
      }, child: const Text("Animated switcher example")),

    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const AnimatedListExample()),
        );
      }, child: const Text("Animated List example")),

    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const PositionedTransitionExample()),
        );
      }, child: const Text("Positioned transition example")),
//
    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const SizeTransitionExample()),
        );
      }, child: const Text("Size transition example")),

    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const RotationTransitionExample()),
        );
      }, child: const Text("Rotatonal transition example")),

     ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const AnimatedBuilderExample()),
        );
      }, child: const Text("Animated builder example")),
    
     ElevatedButton(onPressed: (){
       Navigator.of(context).push(PageFadeTransition(const PageTwo()));
      }, child: const Text(" Page fade transition")),
 
    ElevatedButton(onPressed: (){
       Navigator.of(context).push(PageScaleTransition(const PageTwo()));
      }, child: const Text(" Page scale transition")),

    ElevatedButton(onPressed: (){
       Navigator.of(context).push(PageRotateTransition(const PageTwo()));
      }, child: const Text(" Page rotation transition")),
    
    ElevatedButton(onPressed: (){
       Navigator.of(context).push(PageSlideTransition(const PageTwo()));
      }, child: const Text(" Page slide transition")),

     ElevatedButton(onPressed: (){
       Navigator.of(context).push(PageSizeTransition(const PageTwo()));
      }, child: const Text(" Page size transition")),
       
       ElevatedButton(onPressed: (){
       Navigator.of(context).push(PageMixSizeFadeTransition(const PageTwo()));
      }, child: const Text(" Page mixed fade size transition")),

     ElevatedButton(onPressed: (){
       Navigator.of(context).push(PageMixScaleRotateTransition(const PageTwo()));
      }, child: const Text(" Page mixed rotate scale transition")),

    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const CustomePainterExmaple()),
        );
      }, child: const Text("Custom paint animation")),

    ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const LottieSilderExample()),
        );
      }, child: const Text("Lottie slider example")),
//
     ElevatedButton(onPressed: (){
        Navigator.push(
    context,
      MaterialPageRoute(builder: (context) => const RiveSilderExample()),
        );
      }, child: const Text("Rive Slider example")),


    ])),     
    );
  }
}