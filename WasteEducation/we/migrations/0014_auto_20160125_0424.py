# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-01-25 04:24
from __future__ import unicode_literals

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('we', '0013_auto_20160125_0101'),
    ]

    operations = [
        migrations.RenameField(
            model_name='keepinmindquestion',
            old_name='question_choice_alpha',
            new_name='question_choice',
        ),
        migrations.RemoveField(
            model_name='keepinmindquestion',
            name='question_choice_beta',
        ),
    ]