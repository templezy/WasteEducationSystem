# -*- coding: utf-8 -*-
# Generated by Django 1.9 on 2016-01-27 05:21
from __future__ import unicode_literals

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('we', '0014_auto_20160125_0424'),
    ]

    operations = [
        migrations.CreateModel(
            name='Feedback',
            fields=[
                ('id', models.AutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('feedback_text', models.CharField(default='', max_length=200)),
                ('feedback_content', models.CharField(default='', max_length=300)),
            ],
        ),
    ]
