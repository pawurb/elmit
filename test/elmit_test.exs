defmodule ElmitTest do
  use ExUnit.Case, async: false
  import Mock

  test "parsing user input" do
    user_args = ["pl", "es", "dzień dobry panu", "-t", "-s"]
    expected = [from: "pl", to: "es", text: "dzień dobry panu", t: true, s: true]
    parsed = Elmit.parse_args(user_args)
    assert parsed == expected
  end

  test "full flow does not raise error" do
    mocked_responses = fn(url) ->
      IO.puts url
      cond do
        url =~ ~r/translate_a/ ->
          """
[[["Hola","hello",,,1],[,,,"heˈlō,həˈlō"]],[["wykrzyknik",["¡Hola!","¡Caramba!","¡Oiga!","¡Diga!","¡Bueno!","¡Vale!","¡Aló!"],[["¡Hola!",["Hello!","Hi!","Hey!","Hullo!","Hallo!","Hoy!"],,0.43686765],["¡Caramba!",["Gee!","Well!","Good gracious!","Well I never!","By jingo!","By gum!"]],["¡Oiga!",["Listen!","Hello!","Hullo!","Hallo!","I say!","See here!"]],["¡Diga!",["Hello!","Hullo!","Talk away!"]],["¡Bueno!",["Well!","All right!","Hello!","Hallo!","Hullo!"]],["¡Vale!",["Okay!","O.K.!","OK!","Okey!","Hello!"]],["¡Aló!",["Hello!","Hullo!","Halliard!"]]],"Hello!",9]],"en",,,[["hello",32000,[["Hola",0,true,false],["saludar",0,true,false],["saludo",0,true,false],["del hola",0,true,false]],[[0,5]],"hello",0,0]],1,,[["en"],,[1]],,,[["rzeczownik",[[["howdy","hullo","hi","how-do-you-do"],""]],"hello"],["wykrzyknienie",[[["hi","howdy","hey","hiya","ciao","aloha"],"m_en_us1254307.001"]],"hello"]],[["rzeczownik",[["an utterance of “hello”; a greeting.","m_en_us1254307.006","she was getting polite nods and hellos from people"]],"hello"],["wykrzyknienie",[["used as a greeting or to begin a telephone conversation.","m_en_us1254307.001","hello there, Katie!"]],"hello"],["czasownik",[["say or shout “hello”; greet someone.","m_en_us1254307.007","‘Hi Kirsten,’ he helloed , obviously calling me Kirsten on purpose."]],"hello"]],[[["Yeah, that might sound totally rude of me to say, but \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.005"],["It was a pleasant surprise when Sheila Sheridan came over to say \u003cb\u003ehello\u003c/b\u003e .",,,,3,"m_en_us1254307.001"],["Okay, so maybe costs rose by more than 1% in that period, and maybe sales dropped earlier in the year, but \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.005"],["\u003cb\u003ehello\u003c/b\u003e, what's all this then?",,,,3,"m_en_gb0372340.002"],["I thought it summed up what I wanted to say and it also is a way to say \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.001"],["Like we have time for a life - \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.005"],["Ric's upset when he finds out that Alf returned from the USA the day before and didn't even say \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.001"],["I said \u003cb\u003ehello\u003c/b\u003e to him",,,,3,"neid_9507"],["‘Oh, \u003cb\u003ehello\u003c/b\u003e ,’ she said acting surprised to see the four boys staring at her.",,,,3,"m_en_us1254307.001"],["Excuse him for picking that awful blue hue - I had always told him to let me pick the color to match with his chestnut-blondish hair, but \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.005"],["\u003cb\u003ehello\u003c/b\u003e there, Katie!",,,,3,"m_en_gb0372340.001"],["She turned down the offer to sing the theme to the TV show… \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.005"],["If you haven't met Joy yet, pop over to her site and say \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.001"],["She is living a more fortunate life than (most of) you, \u003cb\u003ehello\u003c/b\u003e ?",,,,3,"m_en_us1254307.005"],["Every gathering she beds another partner who isn't her husband, \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.005"],["\u003cb\u003ehello\u003c/b\u003e, what's this?",,,,3,"neid_9510"],["He was a little surprised since he had already said \u003cb\u003ehello\u003c/b\u003e to her that morning.",,,,3,"m_en_us1254307.001"],["\u003cb\u003ehello\u003c/b\u003e, is anybody in?",,,,3,"neid_9508"],["A man standing in line at the check-out counter of a grocery store was surprised when an attractive woman behind him said \u003cb\u003ehello\u003c/b\u003e .",,,,3,"m_en_us1254307.001"],["When their eyes met, she grinned wickedly in an informal \u003cb\u003ehello\u003c/b\u003e .",,,,3,"m_en_us1254307.006"],["I mean, it's nice in the way he wants to serve my sexual needs, but \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.005"],["I haven't seen her in over a year, and yesterday she just strolls casually up to me and says \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.001"],["Quentin is surprised to see Maggie, and says \u003cb\u003ehello\u003c/b\u003e .",,,,3,"m_en_us1254307.001"],["I have wanted to re-watch it like a DVD or something, but I couldn't because, \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.005"],["But as I was saying, so here I am in the library, panicking because the glue stick has just run out - and it's totally bad form to use tape because I mean, \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.005"],["She must have been really stupid to have mimicked me… I mean, \u003cb\u003ehello\u003c/b\u003e !",,,,3,"m_en_us1254307.005"],["With little more than a \u003cb\u003ehello\u003c/b\u003e , I began to reread the letter that was in my hand.",,,,3,"m_en_us1254307.006"],["My second thought is, \u003cb\u003ehello\u003c/b\u003e , it's still snowing!",,,,3,"m_en_us1254307.003"],["But instead of a normal greeting like saying \u003cb\u003ehello\u003c/b\u003e or something, they hugged.",,,,3,"m_en_us1254307.001"],["\u003cb\u003ehello\u003c/b\u003e, what's all this then?",,,,3,"m_en_us1254307.003"]]],[["Hello!","say hello"]]]
"""
        url =~ ~r/translate_tts/ ->
          "mocked_sound_response"
        true ->
          raise "Issued not mocked request in the tests"
      end
    end

    with_mock HTTPotion, [get: mocked_responses] do
      Elmit.main(["en", "es", "hello"])
      assert true == true
    end
  end
end
