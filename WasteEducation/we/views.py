from django.http import HttpResponse, Http404, HttpResponseRedirect
from django.shortcuts import render, get_object_or_404
from .models import Rubbishbin, Waste, Question, Survey, TrueFalseQuestion
from django.core.urlresolvers import reverse
import random
from rest_framework import viewsets
from rest_framework.parsers import JSONParser
from rest_framework.renderers import JSONRenderer
from serializers import RubbishbinSerializer, QuestionSerializer, SingleQuestionSerializer, TrueFalseSingleQuestionSerializer
# Create your views here.


def index(request):
    latest_rubbishbin_list = Rubbishbin.objects.order_by('bname_text')[:5]
    context = {'latest_rubbishbin_list': latest_rubbishbin_list }
    return render(request, 'we/index.html', context)


def detail(request, rubbishbin_id):
    rubbishbin = get_object_or_404(Rubbishbin, pk=rubbishbin_id)
    return render(request, 'we/detail.html', {'rubbishbin': rubbishbin})


def results(request, rubbishbin_id):
    rubbishbin = get_object_or_404(Rubbishbin, pk=rubbishbin_id)
    return render(request, "we/results.html", {'rubbishbin': rubbishbin})


def choose(request, rubbishbin_id):
    rubbishbin = get_object_or_404(Rubbishbin, pk=rubbishbin_id)
    try:
        selected_waste = rubbishbin.waste_set.get(pk=request.POST['waste'])
    except (KeyError, Waste.DoesNotExist):
        return render(request, 'we/detail.html', {
            'rubbishbin': rubbishbin,
            'error_message': "You did't select the waste.",
        })
    else:
        selected_waste.wcount += 1
        selected_waste.save()
    return HttpResponseRedirect(reverse('we:results', args=(rubbishbin.id,)))


# Test page
def learningcenter(request):
    questionlist = Question.objects.all()
    return render(request, 'we/learning_center.html', {'questionlist': questionlist})


# Introduction of the system page
def ecointro(request):
    return render(request, 'we/ecointro.html')


def survey(request):
    # How many questions in each survey
    question_in_survey = 4
    questionlist_init = Question.objects.all()
    questionid_list = []
    for single_question in questionlist_init:
        questionid_list.append(single_question.id)
    random.shuffle(questionid_list)
    questionlist = []
    for single_id in questionid_list:
        questionlist.append(Question.objects.get(id=single_id))

    questionlist = questionlist[:question_in_survey]
    # Create the survey base on the random questions
    questionlist_count = question_in_survey+1
    return render(request, 'we/survey.html', {'questionlist': questionlist, 'questionlist_count': questionlist_count})


def testresult(request):
    return render(request, 'we/testresult.html')


# Handle the form of the survey
def surveyhandler(request):
    score = 0
    question_count = request.POST.get('question-count')
    for i in range(1, int(question_count)):
        choice_value = request.POST.get('question'+str(i))
        choice_split = choice_value.split('-')
        if Question.objects.get(id=choice_split[0]).choice == choice_split[1]:
            score += int(Question.objects.get(id=choice_split[0]).score)
    return render(request, 'we/testresult.html', {'score': score})


class RubbishbinViewSet(viewsets.ModelViewSet):
    queryset = Rubbishbin.objects.all()
    serializer_class = RubbishbinSerializer


class JSONResponse(HttpResponse):
    def __init__(self, data, **kwargs):
        content = JSONRenderer().render(data)
        kwargs['content_type'] = 'applications/json'
        super(JSONResponse, self).__init__(content, **kwargs)


def question_list(request):
    if request.method == 'GET':
        temp_question = Rubbishbin.objects.all()
        serializer = QuestionSerializer(temp_question, many=True)
        return JSONResponse(serializer.data)
    elif request.method == 'POST':
        data = JSONParser().parse(request)
        serializer = QuestionSerializer(data=data)
        if serializer.is_valid():
            serializer.save()
            return JSONResponse(serializer.data, status=201)
        return JSONResponse(serializer.errors, status=400)


def survey_question(request):
    if request.method == 'GET':
        question_in_survey = 4
        questionlist_init = Question.objects.all()
        questionid_list = []
        for single_question in questionlist_init:
            questionid_list.append(single_question.id)
        random.shuffle(questionid_list)
        questionlist = []
        for single_id in questionid_list:
            questionlist.append(Question.objects.get(id=single_id))

        questionlist = questionlist[:question_in_survey]

        serializer = SingleQuestionSerializer(questionlist, many=True)
        return JSONResponse(serializer.data)


def true_false_quiz(request):
    if request.method == 'GET':
        question_in_survey = 5
        questionlist_init = TrueFalseQuestion.objects.all()
        questionid_list = []
        for single_question in questionlist_init:
            questionid_list.append(single_question.id)
        random.shuffle(questionid_list)
        questionlist = []
        for single_id in questionid_list:
            questionlist.append(TrueFalseQuestion.objects.get(id=single_id))
        questionlist = questionlist[:question_in_survey]

        serializer = TrueFalseSingleQuestionSerializer(questionlist, many=True)
        return JSONResponse(serializer.data)
