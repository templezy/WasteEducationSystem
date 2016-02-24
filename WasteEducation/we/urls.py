from django.conf.urls import url, include
from rest_framework.authtoken import views

from . import views
from .models import Question, Rubbishbin
from rest_framework import routers, serializers, viewsets


app_name = 'we'
urlpatterns = [
    url(r'^$', views.ecointro, name='index'),
    url(r'^rubbishbin/$', views.question_list),
    url(r'^multiple_choice/$', views.survey_question),
    url(r'^true_false_question/$', views.true_false_quiz),
    url(r'^which_bin_question/$', views.which_bin_quiz),
    url(r'^keep_in_mind_question/$', views.keep_in_mind_quiz),
    url(r'^learningcenter/$', views.learningcenter, name='learningcenter'),
    url(r'^cdcalcu/$', views.co2calcu, name='cdcalcu'),
    url(r'^feedback/$', views.feedback),
    url(r'^get_feedback/$', views.get_feedback, name='get_feedback'),
    url(r'^survey/$', views.survey, name='survey'),
    url(r'^surveyhandler/$', views.surveyhandler, name='surveyhandler'),
    url(r'^ecointro/$', views.ecointro, name='ecointro'),
    url(r'^(?P<rubbishbin_id>[0-9]+)/$', views.detail, name='detail'),
    url(r'^(?P<rubbishbin_id>[0-9]+)/results/$', views.results, name='results'),
    url(r'^(?P<rubbishbin_id>[0-9]+)/choose/$', views.choose, name='choose'),
    url(r'^example/$', views.example_view, name='example'),
    url(r'^feedback_list/$', views.feedbacklist, name='feedbacklist'),
]
