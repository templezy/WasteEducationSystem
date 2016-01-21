from .models import Rubbishbin, Question, TrueFalseQuestion
from rest_framework import serializers


class RubbishbinSerializer(serializers.HyperlinkedModelSerializer):

    class Meta:
        model = Rubbishbin
        fields = ('bname_text',)


class QuestionSerializer(serializers.Serializer):

    bname_text = serializers.CharField()

    def create(self, validated_data):
        return Rubbishbin.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.bname_text = validated_data.get('bname_text', instance.bname_text)
        instance.save()
        return instance


class SingleQuestionSerializer(serializers.Serializer):

    question_text = serializers.CharField()
    question_type = serializers.CharField()
    img_url = serializers.CharField()
    video_url = serializers.CharField()
    question_desc = serializers.CharField()
    first_desc = serializers.CharField()
    second_desc = serializers.CharField()
    third_desc = serializers.CharField()
    fourth_desc = serializers.CharField()
    choice = serializers.CharField()
    score = serializers.IntegerField()
    total_times = serializers.IntegerField()

    def create(self, validated_data):
        return Question.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.question_text = validated_data.get('question_text', instance.question_text)
        instance.question_type = validated_data.get('question_type', instance.question_type)
        instance.img_url = validated_data.get('img_url', instance.img_url)
        instance.video_url = validated_data.get('video_url', instance.video_url)
        instance.question_desc = validated_data.get('question_desc', instance.question_desc)
        instance.first_desc = validated_data.get('first_desc', instance.first_desc)
        instance.second_desc = validated_data.get('second_desc', instance.second_desc)
        instance.third_desc = validated_data.get('third_desc', instance.third_desc)
        instance.fourth_desc = validated_data.get('fourth_desc', instance.fourth_desc)
        instance.choice = validated_data.get('choice', instance.choice)
        instance.score = validated_data.get('score', instance.score)
        instance.total_times = validated_data.get('total_times', instance.total_times)
        instance.save()
        return instance


class TrueFalseSingleQuestionSerializer(serializers.Serializer):

    question_text = serializers.CharField()
    question_desc = serializers.CharField()
    question_choice = serializers.CharField()
    question_score = serializers.IntegerField()
    question_total_times = serializers.IntegerField()

    def create(self, validated_data):
        return TrueFalseQuestion.objects.create(**validated_data)

    def update(self, instance, validated_data):
        instance.question_text = validated_data.get('question_text', instance.question_text)
        instance.question_desc = validated_data.get('question_desc', instance.question_desc)
        instance.question_choice = validated_data.get('question_choice', instance.question_choice)
        instance.question_score = validated_data.get('question_score', instance.question_score)
        instance.question_total_times = validated_data.get('question_total_times', instance.question_total_times)
        instance.save()
        return instance
