from django.conf.urls import url, include

from . import views
from .models import Question, Rubbishbin
from rest_framework import routers, serializers, viewsets


app_name = 'we'
urlpatterns = [
    url(r'^$', views.index, name='index'),
    url(r'^rubbishbin/$', views.question_list),
    url(r'^survey_question/$', views.survey_question),
    url(r'^true_false_question/$', views.true_false_quiz),
    url(r'^learningcenter/$', views.learningcenter, name='learningcenter'),
    url(r'^survey/$', views.survey, name='survey'),
    url(r'^surveyhandler/$', views.surveyhandler, name='surveyhandler'),
    url(r'^ecointro/$', views.ecointro, name='ecointro'),
    url(r'^(?P<rubbishbin_id>[0-9]+)/$', views.detail, name='detail'),
    url(r'^(?P<rubbishbin_id>[0-9]+)/results/$', views.results, name='results'),
    url(r'^(?P<rubbishbin_id>[0-9]+)/choose/$', views.choose, name='choose'),
]
