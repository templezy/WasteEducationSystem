# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-01-31 23:19
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('we', '0015_feedback'),
    ]

    operations = [
        migrations.AddField(
            model_name='truefalsequestion',
            name='question_reason',
            field=models.CharField(default='', max_length=500),
        ),
    ]