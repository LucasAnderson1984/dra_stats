# frozen_string_literal: true

require 'rails_helper'

describe 'dra_score_students', type: :request do
  let(:headers) do
    {
      'Accept' => 'application/vnd.api+json',
      'Content-Type' => 'application/vnd.api+json'
    }
  end
  let(:params) { { dra_score_student: dra_score_student }.to_json }

  subject do
    request!

    response
  end

  describe 'GET index' do
    before do
      dra_score_students
    end

    let(:request!) { get dra_score_students_path, headers: headers }

    context 'when there are no dra_score_students' do
      let(:dra_score_students) {}

      it { is_expected.to have_http_status(:ok) }
      it 'should return an empty array' do
        body = JSON.parse(subject.body)

        expect(body).to be_empty
      end
    end

    context 'when there are dra_score_students' do
      let(:dra_score_students) { create_list(:dra_score_student, 2) }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a list of dra_score_students' do
        body = JSON.parse(subject.body)

        expect(body.size).to eq(dra_score_students.size)

        body.each_with_index do |dra_score_student, index|
          expect(dra_score_student['id']).to eq(dra_score_students[index].id)
          expect(dra_score_student['dra_score_id'])
            .to eq(dra_score_students[index].dra_score_id)
          expect(dra_score_student['student_id'])
            .to eq(dra_score_students[index].student_id)
          expect(dra_score_student['score_date'].to_date)
            .to eq(dra_score_students[index].score_date)
        end
      end
    end
  end

  describe 'GET show' do
    before do
      dra_score_student_id
    end

    let(:request!) { get dra_score_student_path(dra_score_student_id) }

    context 'when the dra_score_student can be found' do
      let(:dra_score_student) { create(:dra_score_student) }
      let(:dra_score_student_id) { dra_score_student.id }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a dra_score_student' do
        body = JSON.parse(subject.body)

        expect(body['id']).to eq(dra_score_student.id)
        expect(body['dra_score_id']).to eq(dra_score_student.dra_score_id)
        expect(body['student_id']).to eq(dra_score_student.student_id)
        expect(body['score_date'].to_date).to eq(dra_score_student.score_date)
      end
    end

    context 'when the dra_score_student can not be found' do
      let(:dra_score_student_id) { SecureRandom.uuid }

      it { is_expected.to have_http_status(:not_found) }
      it 'should return an error message' do
        body = JSON.parse(subject.body)

        expect(body)
          .to eq(
            "Couldn't find DraScoreStudent with 'id'=#{dra_score_student_id}"
          )
      end
    end
  end

  describe 'POST create' do
    let(:request!) do
      post dra_score_students_path,
           params: params,
           headers: headers
    end

    context 'when the dra_score_student attributes are valid' do
      let(:dra_score) { create(:dra_score) }
      let(:dra_score_student) do
        attributes_for(
          :dra_score_student,
          dra_score_id: dra_score.id,
          student_id: student.id
        )
      end
      let(:student) { create(:student) }

      it { is_expected.to have_http_status(:ok) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('dra_score_students.create.success'))
      end
    end

    context 'when the dra_score_student attributes are not valid' do
      let(:dra_score_student) do
        attributes_for(:dra_score_student, score_date: nil)
      end

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('dra_score_students.create.failure'))
      end
    end
  end

  describe 'PATCH update' do
    let(:request!) do
      patch dra_score_student_path(dra_score_student_id),
            params: params,
            headers: headers
    end

    context 'when the dra_score_student is valid' do
      let(:params) do
        {
          dra_score_student: { score_date: dra_score_student.score_date + 1 }
        }.to_json
      end
      let(:dra_score_student) { create(:dra_score_student) }
      let(:dra_score_student_id) { dra_score_student.id }

      it { is_expected.to have_http_status(:ok) }
      it 'they see a success message' do
        body = JSON.parse(subject.body)

        expect(body['message'])
          .to eq(I18n.t('dra_score_students.update.success'))
        expect(body['resource']['score_date'].to_date)
          .to eq(dra_score_student.score_date + 1)
      end
    end

    context 'when the dra_score_student is not valid' do
      let(:params) do
        {
          dra_score_student: { score_date: 'test' }
        }.to_json
      end
      let(:dra_score_student) { create(:dra_score_student) }
      let(:dra_score_student_id) { dra_score_student.id }

      it { is_expected.to have_http_status(:unprocessable_entity) }
      it 'should return a success message' do
        message = JSON.parse(subject.body)['message']

        expect(message).to eq(I18n.t('dra_score_students.update.failure'))
      end
    end

    context 'when the dra_score_student is not found' do
      let(:params) do
        {
          dra_score_student: { score_date: dra_score_student.score_date + 1 }
        }.to_json
      end
      let(:dra_score_student) { create(:dra_score_student) }
      let(:dra_score_student_id) { SecureRandom.uuid }

      it { is_expected.to have_http_status(:not_found) }
      it 'should return an error message' do
        body = JSON.parse(subject.body)

        expect(body)
          .to eq(
            "Couldn't find DraScoreStudent with 'id'=#{dra_score_student_id}"
          )
      end
    end
  end

  describe 'DELETE destory' do
    let(:request!) do
      delete dra_score_student_path(dra_score_student_id),
             params: params,
             headers: headers
    end

    context 'when the student exists' do
      let(:dra_score_student) { create(:dra_score_student) }
      let(:dra_score_student_id) { dra_score_student.id }

      it { is_expected.to have_http_status(:ok) }
      it 'they see a success message' do
        body = JSON.parse(subject.body)

        expect(body['message'])
          .to eq(I18n.t('dra_score_students.destroy.success'))
      end
    end

    context 'when the student does not exist' do
      let(:dra_score_student) { create(:dra_score_student) }
      let(:dra_score_student_id) { SecureRandom.uuid }

      it { is_expected.to have_http_status(:not_found) }
      it 'should return an error message' do
        body = JSON.parse(subject.body)

        expect(body)
          .to eq(
            "Couldn't find DraScoreStudent with 'id'=#{dra_score_student_id}"
          )
      end
    end
  end
end
